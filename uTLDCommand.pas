unit utldcommand;

interface

uses sysutils, DateUtils, Dialogs, Classes,
  uMyCOMPort, syncobjs, ExtCtrls, stdctrls, messages, graphics, controls, buttons, forms,
  Inifiles,
  uDosimeter,
  uDetector,
  uConst,
  //uSetConnection,
  IdModbusClient,
  ModbusTypes,
  IdUDPServer,
  IdUDPClient,
  IdGlobal,
  IdSocketHandle,
  ulanguages;

const
// Состояния ProcessStatus для панели
  procstateScanInDB        = 0;  // D0
  procstateInfoMessage     = 1;  // D1
  procstateFailMessage     = 2;  // D2
  procstateWasPushOut      = 5;  // D5
  procstateDosimeterInMove = 6;  // D6
type
  PacketBuffTitle = packed array [0 .. 9] of byte; // для принятого массива заголовка
  PacketModBusBuff = packed array [0 .. 255] of byte; // для modbus протокола

  TArrayToInteger = packed record
                     case integer of
                     1: (ArrayBuff: array [0..7] of byte);
                     2: (I: Int64);
                     3: (R: single);
                     end;

  TModBusExchange           = procedure(Log: String) of object;                                       // отображение всех пакетов (modbus-обмен)
  TCommandLog               = procedure(Time, Msg, Inf: String; MsgType, MsgPriority: integer) of object;  // запросы/ответы команд
  TConnectionState          = procedure(Msg: String; COMPort: String) of object;                      // состояние связи с COM портом
  TTLDNoAnswer              = procedure (NoAnswer: boolean) of object;                                // состояние связи с ТЛД
  TTLDMeasuring             = procedure (Measuring: boolean) of object;                               // состояние режима измерения
  TReinitialize             = procedure of object;

  TReadMotorData = packed record
    Status    : word;
    Message   : word;
    Progress  : word;
  end;

  TWriteMotorData = packed record
    MaxSteps : word;
    NumVars  : word;
    Vars     : packed array [1..10] of word;
  end;

  TMotorsBoard = packed record // информация от платы управления шаговыми движками (MODBUS адрес = $01)  - плата от Игоря Автушенко
  case integer of
    1:
    (
      Protocol         : word;                                //   0:    // версия протокола 1 - базовая
      Common_Status    : word;                                //   1:
      ReadMotor       : packed array[1..6] of TReadMotorData; //   2-19; // данные от шаговых двигателей
      Power_Status    : word;                                 //   20:
      DigitalOutput   : word;                                 //   21:   // цифровые выходы
      DigitalInput    : word;                                 //   22:   // цифровые входы
      Reserved1       : packed array [0..16] of word;         //   23:
      Motor_Command   : packed array[1..6] of word;           //   40-45:
      Power_Command   : word;                                 //   46:
      Reserved2       : packed array [0..53] of word;         //   47-100:
      WriteMotor      : packed array[1..6] of TWriteMotorData;//   101-172;
      CMD_SaveEEPROM  : word;                                 //   173;
      DeviceNumber    : word;                                 //   174;
      Stat_NumMoves   : word;                                 //   175;
      Stat_NumMovesTo1: word;                                 //   176;
      Stat_NumErrMoves: word;                                 //   177;
      StatCorr_Min    : word;                                 //   178;
      StatCorr_Max    : word;                                 //   179;
      StatCorr_Avg    : word;                                 //   180;
      EEPROMCounter   : word;                                 //   181;

      // Теперь мои собственные переменные (без привязки к плате)
      Connected: boolean; // признак связи
      IgnoreAnswerError: boolean; // Игнорировать ошибку 3 при ответе на выполнение команды
      IrradiationEDR  : real; // мощность дозы встроенного облучателя
      IrradiationTime : real; // - время облучения (текущее расчётное)

    );
    2: (ByteArray : packed array [0 .. 400] of byte;);
    3: (WordArray : packed array [0 .. 200] of word;);
  end;

  TAirHeatBoard = packed record // информация от платы управления нагревателем газа (MODBUS адрес = $20)
  case boolean of
    true:
    (
    { // HeatStatus
    Channle 1 Enable: Heating status & 0x01
    Channle 2 Enable: Heating status & 0x02
    Channle 3 Enable: Heating status & 0x04
    Channle 4 Enable: Heating status & 0x08
    Channle 1 Status: Heating status & 0x0007
    Channle 2 Status: Heating status & 0x0070
    Channle 3 Status: Heating status & 0x0700
    Channle 4 Status: Heating status & 0x7000
    For each channle:
    0 -> Ready
    1 -> Preheating
    2 -> Preheat Keep
    3 -> Heating
    4 -> Heat Keep
    5 -> Wait Cooling
    }
    Pressure                    : word;  // deactivated       // 0
    Temperature                 : packed array[1..4] of word; // 1-4 //
    Flow                        : packed array[1..4] of word; // 5-8
    HeatStatus                  : word;                       // 9
    HeatMode                    : word;  // deactivated       // 10 ($0A) // В новой версии платы будет Preassure
    PreHeatTemperature          : word;                       // 11 ($0B) // Температура предпрогрева, градусы Целсия
    PreHeatRate                 : word;                       // 12 ($0C) // Скорость предпрогрева, Градусы в секунду
    //PreHeatTime                 : byte;                       // 14? ($0E) // Время предпрогрева, секунды
    PreHeatTime                 : word;                       // 13 ($0D) // Время предпрогрева, секунды
    HeatTemperature             : word;                       // 14 ($0E) // Температура прогрева при измерении, градусы Цельсия
    HeatRate                    : word;                       // 15 ($0F) // Скорость прогрева при измерении, Градусы в секунду
    //HeatTime                          : byte;                       // 17? ($11) // Время прогрева при измерении, секунды
    HeatTime                    : word;                       // 16 ($10) // Время прогрева при измерении, секунды

    Position                    : word;                       // 17 ($11) AirHeatNew - Channel selection bit mask
    HeatingCtrl                 : word;                       // 18 ($12) AirHeatNew - Write 0 to stop and 1 to start. Read returns 1 if any channel is heating, otherwise 0
    ErrorCode                   : word;                       // 19 ($13) AirHeatNew - Сюда переместится код ошибки из запроса Input
    // Теперь мои собственные переменные (без привязки к плате)
    Connected: boolean; // признак связи
    OldVersion: boolean; // признак первой версии платы (с ошибкой в регистрах MODBUS)
    );
    false: (ByteArray           : packed array [0 .. 60] of byte;);
  end;

  TPMTBoard = packed record // информация от платы считывания ФЭУ (MODBUS адрес = $80)
  case boolean of
  true:
  (
    CounterTrigerring           : word;                         // 0        // Счёт импульсов?
    VoltageAdjustment           : packed array[1..2] of word;   // 1-2      // Коррекция высокого для первого и второго ФЭУ?
    PreHeatTime                 : word;                         // 3        // Время предпрогрева, секунды
    MeasureTime                 : word;                         // 4        // Время прогрева при измерении, секунды
    MeasureTime2                : word;                         // 5        // --- тут неясность в описании
    RealTimeCount               : packed array[1..2] of single; // 6-9      // Счёт импульсов по каналам, Float ABCD
    PreheatCount                : packed array[1..2] of single; // 10-13 ($0A)   // Счёт импульсов по предпрогреву?
    MeasureCount                : packed array[1..2] of single; // 14-17 ($0E)   // Счёт импульсов по измерению?
    UID                         : packed array[1..2] of dword;  // 18-21 ($12)   // Уникальные ID?
    HighVoltageInit             : packed array[1..2] of word;   // 22-25 ($16)   // Начальное высокое?
    CPS                         : word;                         // 26    ($1A)   // Скоростоь счёта (в описании $00 - может быть ошибка)
    DeviceAddress               : word;                         // 27    ($1B)   // DeviceAddress (в описании $00 - может быть ошибка)
    // Теперь мои собственные переменные (без привязки к плате)
    Connected: boolean; // признак связи
    );
    false: (ByteArray                 : packed array [0 .. 55] of byte;);
  end;

  TTwoChanels = packed record
    Channel1: dword;
    Channel2: dword;
  end;
{
  TPMTNew = packed record // информация от платы новой считывания ФЭУ (MODBUS адрес = $0A)  - плата от Юры Теверовского
  case boolean of
  true:
  (
    MB_REG_MEASURE_INSTANT_CH1	: DWord;	                   // 0x00   R	Мгновенное значение канал 1
    MB_REG_MEASURE_INSTANT_CH2	: DWord;	                   // 0x02   R	Мгновенное значение канал 2
    MB_REG_MEASURE_NUM_CH1	: Word;                            // 0x04   R	Количество накопленных данных канал 1
    MB_REG_MEASURE_NUM_CH2	: Word;                            // 0x05   R	Количество накопленных данных канал 2
    MB_REG_MEASURE_TIME	        : Word;	                           // 0x06   RW	Длительность измерения, с
    MB_REG_RESTART	        : Word;	                           // 0x07   RW	Перезапуск измерения
    MB_REG_BUFFER_CH1         	: packed array [0 .. 299] of dword;       //0x08   R	КТВ канал 1
    MB_REG_BUFFER_CH2	        : packed array [0 .. 299] of dword;       //0x260  R	КТВ канал 2
    MB_REG_BUFFER_TOTAL	        : packed array [0 .. 299] of TTwoChanels; //0x4B8  R	КТВ с обоих каналов (общий буфер)
    // Теперь мои собственные переменные (без привязки к плате)
    CurrentReaded               : Word;  // число уже прочитанных каналов КТВ
    CurrentReadedPrev           : Word;  // число ранее прочитанных каналов КТВ
    CurrentTemp                 : Word;  // Предыдущая температура
    CurrentTempPrev             : Word;  // Предыдущая температура
    CurrentPulsesMax_Ch1        : DWord; // Текущий максимум канала 1 (для масштабирования)
    CurrentPulsesMax_Ch2        : DWord; // Текущий максимум канала 2 (для масштабирования)
    Connected: boolean; // признак связи
    );
    false: (ByteArray                 : packed array [0 .. 4815] of byte;);
  end;
}
  TPMTNew2 = packed record // информация от платы новой считывания ФЭУ (MODBUS адрес = $0A)  - новая плата от Козлова Александра  - след.мода после PMTNew
  case boolean of
  true:
  (
    Measure_instant_ch1	 : DWord;	                              // 0x00   R   Мгновенное значение канал 1
    Measure_instant_ch2	 : DWord;	                              // 0x02   R   Мгновенное значение канал 2
    Measure_num_ch1	 : Word;                                      // 0x04   R   Количество накопленных данных канал 1
    Measure_num_ch2	 : Word;                                      // 0x05   R   Количество накопленных данных канал 2
    Measure_time	 : Word;	                              // 0x06   RW  Длительность измерения, с
    Restart	         : Word;	                              // 0x07   RW  Перезапуск измерения

    Dark_current_start   : Word;                                      // 0x08   RW  Запуск измерение темнового тока
    Ref_src_start        : Word;                                      // 0x09   RW  Запуск измерения контрольного источника
    Enable_led_1         : Word;                                      // 0x0A   RW  Вкл/Выкл светодиода 1
    Enable_led_2         : Word;                                      // 0x0B   RW  Вкл/Выкл светодиода 2

    Dark_current_val_ch1 : DWord;                                     // 0x0C   R   Значение теневого тока канал 1
    Dark_current_val_ch2 : DWord;                                     // 0x0E   R   Значение теневого тока канал 2
    Ref_src_val_ch1      : DWord;                                     // 0x10   R   Значение контрольного источника канал 1
    Ref_src_val_ch2      : DWord;                                     // 0x12   R   Значение контрольного источника канал 2
    Temp_ch1             : single;                                    // 0x14   R   Температура датчик 1
    Temp_ch2             : single;                                    // 0x16   R   Температура датчик 2
    Temp_setpoint        : single;                                    // 0x18   RW  Заданная температура
    Peltier_enable       : Word;                                      // 0x1A   RW  Вкл/выкл Пельтье

    Dark_ref_Time        : Word;                                      // 0x1B   R   Время измерения темнового тока и тока от источника
    IsMeasuring          : Word;                                      // 0x1C   R   =1 - Производится измерение темнового тока или тока от источника

    Manual_mode          : Word;                                      // 0x1D   RW  Флаг ручного режима
    Pwm_setpoint         : Word;                                      // 0x1E   RW  Заданный ШИМ сигнал
    Pwm_actual           : Word;                                      // 0x1F   R   Фактический ШИМ сигнал
    Pwm_max              : Word;                                      // 0x20   RW  Максимальная скважность
    Pwm_min              : Word;                                      // 0x21   RW  Минимальная скважность
    //UNUSED_BUFFER        : packed array [1 .. 1174] of word;          // 0x22       RESERVED ($4B8-$22)
    //UNUSED_BUFFER        : packed array [1 .. ($4B8-$23)] of word;          // 0x22       RESERVED ($4B8-$22)
    //strange_ins: packed array[0..2] of byte;
    Buffer_total         : packed array [0 .. 299] of TTwoChanels;    // 0x4B8  R   КТВ с обоих каналов (общий буфер)
    Device_id            : DWord;                                     // 0x968  RW  Номер установки
    Modbus_adress	 : Word;                                      // 0x96A  RW  Адрес modbus


    // Теперь мои собственные переменные (без привязки к плате)
    PROTECTED_BUFFER     : packed array [0 .. 1599] of word;           // 0x22       RESERVED 496

    CurrentReaded        : Word;  // число уже прочитанных каналов КТВ
    CurrentReadedPrev    : Word;  // число ранее прочитанных каналов КТВ
    CurrentTemp          : Word;  // Предыдущая температура
    CurrentTempPrev      : Word;  // Предыдущая температура
    CurrentPulsesMax_Ch1 : DWord; // Текущий максимум канала 1 (для масштабирования)
    CurrentPulsesMax_Ch2 : DWord; // Текущий максимум канала 2 (для масштабирования)
    TargetTempFromIni    : single;  // Настройка в проге по целевой температуре в Пельтье
    Connected            : boolean; // признак связи
    );
    false: (ByteArray                 : packed array [0 .. 60000] of byte;);  //  с избытком
  end;

  TScanBoard = packed record // информация от платы сканера штрихкода (MODBUS адрес = $60)
  case boolean of
  true:
  (
    BarCodeControl       : word;                       // 0        // 1: Start barcode scanning | 0: Idel
    BarCodeScanStatus    : word;                       // 1        // 1: Barcode recognized | 0: No barcode detected
    BarrelSensor         : word;                       // 2        // Single bit represents a barrel channel status
    BarCodeLength        : word;                       // 3        //
    BarCode              : packed array[0..79] of byte;// 4-43     // Код кассеты (зависит от типа)
{ Determine the number of barcode data registers based on the barcode length (each register stores 2 ASCII characters).
 When reading barcode data, first check the scan status bit and barcode length.
 If the barcode scan is completed, read the corresponding number of registers according to the decoded length.
 Barcode length exceeding 40 characters will trigger overflow error. Number of registers = [barcode length / 2] (rounded up)}
    // Теперь мои собственные переменные (без привязки к плате)
    Connected: boolean; // признак связи
  );
  false: (ByteArray                   : packed array [0 .. 87] of byte;);
  end;

  TMonitorBoard = packed record // информация от платы управления - не используется? (MODBUS адрес = $40)  - не используемая больше плата от китайцев
  case boolean of
  true:
  (
    CurrentTemperature                : word;                       // 0
    TargetTemperature                 : word;                       // 1
    ReferenceLight                    : packed array[1..4] of word; // 2-5
    // Теперь мои собственные переменные (без привязки к плате)
    TargetTempFromIni                 : word;
    Connected: boolean; // признак связи
    );
  false: (ByteArray                   : packed array [0 .. 11] of byte;);
  end;

  TUserPanelIn = packed record // информация от панели
  case boolean of
  true:
  (
    Command               : word;  // 000 - Команда компу из панели: 1- Старт, 2 - Стоп, 3 - Пауза, 4 - ShutDown PC
    ScreenNumberCmd       : word;  // 001
    ScreenNumberBack      : word;  // 002
    DialogResult          : word;  // 003
    );
  false: ( WordArray                   : packed array [0 .. 124] of word;);
  end;
  TUserPanelOut = packed record // информация в панель
  case boolean of
  true:
  (
    Command               : word;         //0 - номер окна 0-10, 1-Motors, 2 - Check and Scan, 3 - КТВ1, 4- КТВ2
    TLD_Mode              : word;         //1
    TLD_Command           : smallint;     //2
    Status                : word;
    Connected             : word;         //4
    AirHeat_Temp1         : word;
    AirHeat_Temp2         : word;         //6
    AirHeat_Flow1         : word;
    AirHeat_Flow2         : word;         //8
    AirHeat_PreHeat_Temp  : word;
    AirHeat_PreHeat_Time  : word;         //10
    AirHeat_PreHeat_Rate  : word;
    AirHeat_Heat_Temp     : word;         //12
    AirHeat_Heat_Time     : word;
    AirHeat_Heat_Rate     : word;         //14
    AirHeat_BurnHeat_Temp : word;
    AirHeat_BurnHeat_Time : word;         //16
    AirHeat_BurnHeat_Rate : word;
    Monitor_Current_Temp  : word;         //18
    Monitor_Target_Temp   : word;
    Monitor_RLCIntencity1 : word;         //20
    Monitor_RLCIntencity2 : word;
    Motors_CommonStatus   : word;         //22
    Motors_InputLines     : word; // 0-ШД1_D13, 1-ШД1_D14, 2-ШД1_D15, 3-ШД2_D14, 4-ШД2_D15, 5-ШД3_D14, 6-ШД3_D15, 7-ШД4_D14, 8-ШД5_D14, 9-ШД5_D15, 10-PowerLine1, 11-PowerLine2
    Motors_Status         : packed array[1..5] of word;
    Motors_D1_Progress    : word;         //29
    Motors_D1_Position    : word;         //30
    DosimeterName         : packed array[1..14] of byte; //31 (07 words)
    PMTNew_Instant1       : word;         //38
    PMTNew_Instant2       : word;         //39
    PMTNew_MeasureTime    : word;         //40
    D1_KTVControl         : word;         //41
    D1_CurrentReaded      : word;         //42
    D2_KTVControl         : word;         //43
    D2_CurrentReaded      : word;         //44
    D3_KTVControl         : word;         //45
    D3_CurrentReaded      : word;         //46
    D4_KTVControl         : word;         //47
    D4_CurrentReaded      : word;         //48
    AutoIncrement         : word;         //49 - для индикации связи
    TLD_Mode_Length       : word;         //50 - для прогрессбара выполнения алгоритма
    DetectorsCount        : word;         //51 - Число детекторов в текущем дозиметре
    Dosimeter_DoseHp10g   : single;       //52 - Померенная доза дозиметра, Hp10g
    Dosimeter_DoseHp10n   : single;       //54 - Померенная доза дозиметра, Hp10n
    Dosimeter_DoseHp007   : single;       //56 - Померенная доза дозиметра, Hp007
    Dosimeter_DoseHp3     : single;       //58 - Померенная доза дозиметра, Hp3
    Reserv1               : single;       //60
    Reserv2               : single;       //62
    Detector_Dose         : packed array [1..4] of single;  //64 - Доза по детекторам.
    ProcessStatus         : word;         //72 - D0:Дозиметр в базе, D1:Info Meassage, D2:Fail Meassage, D3,D4 - Reserved Message Types, D5:Есть сброшеные в отвал дозиметры, D6:На каретке есть дозиметр
    AccidentNumber        : word;         //73 - Номер аварийного или информационного сообщения
    DosimeterType         : packed array[1..18] of byte; //74 - 82 (09 words)
  );
  false: ( Write1000                   : packed array [0 .. 124] of word;);
  end;
  TUserPanel = record // информация от панели и для оной
    Input                    : TUserPanelIn;
    Output                   : TUserPanelOut;
    Connected                : boolean; // признак связи
    DontUse                  : boolean;
  end;

  TDosimeterFound = (dsfNone, dsfNotFound, dsfFound);
  TCurrentDetectors = record
    time_preheat : real; // Время предпрогрева
    time_meas    : real; // Время нагрева для рабочего измерения
    time_burn    : real; // Время отжига

    temp_preheat : real; // Температура предпрогрева
    temp_meas    : real; // Температура нагрева для рабочего измерения
    temp_burn    : real; // Температура отжига

    temp_rate    : real; // Скорость нагрева к рабочей температуре

    sumTimes     : real; // Сумма времён в профиле - для оценки общего времени съёма КТВ

    can_preheat  : real; // Время предпрогрева в каналах
    can_meas     : real; // Время нагрева для рабочего измерения в каналах
    can_burn     : real; // Время отжига в каналах
  end;

  //TCarretePosition = (carUnknown, carDet14, carDet23);
  TCarretePosition = (carDet14, carDet23);
  TAlgorithms = record // информация от пользователя для управления процессами
    CurrentCarretePosition: TCarretePosition;
  end;

  TChangeData = record // информация от пользователя для управления процессами
    DosimeterFound: TDosimeterFound;
    DetectorCount: integer;
    IsStopped: boolean; //мягкая приостановка измерений
    Detectors: array [TCarretePosition] of TCurrentDetectors;
    WaitTime: integer; // Параметр ожидания при отжиге, инициализации двигателей и т.п. (в алгоритме Delay)
  end;

  TAccident = (accLowFlow,accUnknown);
  { TTLD_Auto }

  TTLD_Auto = class
    private
      //COMPort                     : TMyCOMPort;
      FCOM                            : String;
      //FBaudRate                       : integer;
      //FStopBits                       : integer;
      //FParity                         : integer;
      //FByteSize                       : integer;
      FConnectedPort                  : boolean;

      FOnConnectionState              : TConnectionState;

      //FOnTLDError                     : TTLDError;
      //FOnTLDNoAnswer                  : TTLDNoAnswer;
      FOnTLDMeasuring                 : TTLDMeasuring;

      FEmulator                       : boolean;

      FLastSendedPacket               : String;

      FCOMPortFaultFlag               : boolean;

      FWatchdogTimer                  : TTimer; // периодическая проверка COMPortSyn.MyThread.HasConnectionFault и автоматическое восстановление связи

      //FMeasurePos                     : integer;                           //   измерительное положение (0 - нет детекторов, 1 - Первая пара детекторов, 2 - Вторая пара детекторов)

      //EmulatorAnswer1                 : PacketModBusBuff;
      //EmulatorAnswer2                 : PacketModBusBuff;

      //CNTResult                       : integer;          // счетчик для разбора считываемых результатов измерений

      CNTReadPositionErr              : integer;

      PreviousCNTQuery                : integer;
      //PreviousCNTResult               : integer;

      FCRCCntErr_MeasResult           : integer;

      LastMotorSet                    : integer; // Номер шагового двигателя, к которому обращались в последний раз (для правильной интерпретации)
      LastParams                      : string;
      LastTag                         : Int64;

      function ConvertToWord(Byte_1, Byte_2: Byte): Word;
      function ConvertToDWord(Byte_1, Byte_2, Byte_3, Byte_4: Byte): DWord;
      function ConvertToDWord2(Byte_1, Byte_2, Byte_3, Byte_4: Byte): DWord;
      function ConvertToInt64(Byte_1, Byte_2, Byte_3, Byte_4, Byte_5, Byte_6, Byte_7, Byte_8: Byte): Int64;  // функция для перевода байтов в integer
      function ConvertSingleToSingle(aSingle: Single): Single;  // функция для переворачивания байтов Single  0<-->3
      function ConvertSingleToSingle2(aSingle: Single): Single;  // функция для переворачивания байтов Single  0<-->1, 2<-->3
      function ByteToWord(aData: array of byte; aLast: integer): WORD; // функция перевода Byte в Word
      function ByteToWord2(aData: array of byte; aLast: integer): WORD; // функция перевода Byte в Word
      function StringToArray(aBody: String; var aCountBytes: integer): Rbuff; // строку пререписываем побайтно в массив
      function CalculateModBusCRC(aData: array of byte;aBytes: integer):word; // функция подсчета CRC Modbus полученного пакета
      function MakeStringModBusPacket(PacketWithCRC: RBuff; CountBytesToWrite: integer): String;
      //function ReadString: RAWByteString;  // не используется


      //      - Тут надо всё переделать когда заработает хоть как-то
      procedure SetCOM(aCOMName: String);
      procedure TLDAnswer(Packet: PacketModBusBuff; Bytes: integer); // Разбор возвращающихся в MODBUS RTU данных
      procedure AsynchroOnReceiveModbus(ReciveBytes: Cardinal; RecivBuff: RBuff); // для асинхронного опроса Modbus устройств
      //procedure ReadCom;  // не используется
      procedure ModbusReadWriteComand_03_06_10(SendPacket: String);
      procedure ModbusReadWriteEmulator(SendPacket: String);
      procedure PrepareModBusPacket(Packet: String; var aPacketWithCRC: RBuff; var aCountBytesToWrite: integer);

      procedure OnPanelFailure(Sender: TObject);
      procedure OnPanelResponseError(const FunctionCode: Byte; const ErrorCode: Byte; const ResponseBuffer: TModBusResponseBuffer);

    protected

    public
      isFirstTimeStart    : boolean; // Признак первого старта программы (по отсутствию инициализации шаговых двигателей)
      COMPortSyn          : TCOMPortSyn;
      ModbusClient        : TIdModBusClient;

      CNTQuery            : integer;   // номер текущей команды
      SendPacketTime      : TDateTime; // Метка времени последнего отправленного в COM-порт пакета

      // блок описания установки
      Motors              : TMotorsBoard;                      // плата управления шаговыми двигателями (ШД)
      AirHeat             : TAirHeatBoard;                     // плата управления нагревателем воздуха
      //PMTBoard            : TPMTBoard;                         // плата ФЭУ и датчики температуры (ФЭУ старый способ)
      //PMTNew              : TPMTNew;                           // новая плата контроля ФЭУ
      PMT                 : TPMTNew2;                          // ещё более новая плата контроля ФЭУ
      Scaner              : TScanBoard;                        // сканер штрихкода
      //MonitorBoard      : TMonitorBoard;                     // плата управления
      Panel               : TUserPanel;                        // информация из панели и для панели
      ChangeData          : TChangeData;                // информация от пользователя для управления процессами
      Algorithms          : TAlgorithms;                       // информация для работы алгоритмов (TLD_CommandSeries)

      BarCodeString       : ansistring;                        // последний считанный штрихкод с номером дозиметра

      TempProfile         : array [0..299] of integer;         //  блок данных заданного температурного профиля
      StoveProfile        : array [0..605] of byte;            //  блок данных температурного профиля (с длительностью нагрева и отклонением) для записи в прибор
      StoveTemp           : double;                            //  текущая температура печки
      HeatingDuration     : double;                            //  длительность нагрева
      HeatingDeviation    : double;                            //  допустимое отклонение при нагреве
      StartMeasuringFlag  : boolean;                           //  флаг начала измерений
      MeasuringKSIFlag    : boolean;                           //  флаг считывания КСИ
      StateCommand        : integer;                           //  сотсояние выполнения команды
      StateEngine         : integer;                           //  ошибки каналов ШД
      StateStove          : integer;                           //  ошибки в работе печек
      ReadyPoints         : integer;                           //  количество измеренных точек
      KS                  : integer;                           //  КСИ
      WorkingTime         : dword;                             //  время работы установки
      SavedWorkingTime    : dword;                             //

      WritePacketActive   : boolean;
      TempResult          : array[0..299] of integer;          //  блок данных измеренного температурного профиля
      TempResult1         : array[0..299] of integer;          //  блок данных измеренного температурного профиля канал 1
      TempResult2         : array[0..299] of integer;          //  блок данных измеренного температурного профиля канал 2
      ImpulseResult       : array of int64;                    //  блок данных импульсов с ФЭУ
      DetNumber           : integer;                           //  номер детектора, к которому относятся данные
      MeasurePos          : integer;                           //   измерительное положение (0 - нет детекторов, 1 - Первая пара детекторов, 2 - Вторая пара детекторов)

      TLDReset            : boolean;

      NoAnswerCount       : integer;

      AnswerTime          : TDateTime;        // засекаем время ответа              (для индикации потери связи)
      StartTime           : TDateTime;        // засекаем время старта измерений (от команды cCNTAirHeatA2_OLD:)

      IsTranslatorServer  : boolean;          // работа с COM по удалёнке
      IsTranslatorClient  : boolean;          // работа с COM по удалёнке
      TransServer         : TIdUDPServer;
      Host                : String;

      // СОБЫТИЯ ПОСЛЕ УСПЕШНОЙ ОТРАБОТКИ КОМАНД
      OnCMDAccident         : procedure(anAccident: TAccident; accMessaqge: string) of object;       // При аварийной ситуации
      OnReceiveDeviceID     : procedure(Value: integer) of object;              // После успешного чтения ID установки
      OnMotorsReadBase      : procedure of object;                              // После успешного чтения данных платы момторов
      OnMotorsReadProgress  : procedure(aMotorID: integer) of object;           // После успешного чтения текущего прогресса команды мотора
      OnMotorsSetPosition   : procedure(aMotorID: integer) of object;           // После позиционирования шагового двигателя
      OnMotorsStop          : procedure(aMotorID: integer) of object;           // После аварийной остановки шагового двигателя
      OnMotorsInit          : procedure(aMotorID: integer) of object;           // После инициализация шагового двигателя
      OnMotorsReadRWParams1 : procedure of object;                              // После считывания записываемых параметров моторного блока (РЕГИСТРЫ 40-46)
      OnMotorsReadRWParams2 : procedure of object;                              // После считывания записываемых параметров моторного блока (РЕГИСТРЫ 101-172)
      OnAirHeatReadAll      : procedure of object;                              // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ПЛАТЫ НАГРЕВАТЕЛЯ ВОЗДУХА
      OnMonitorReadAll      : procedure of object;                              // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ МОНИТОРА
      OnPMTBoardReadAll     : procedure of object;                              // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ
      OnPMTBoardWriteAll    : procedure of object;                              // ЗАПИСАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ
      OnPMTNewReadBase      : procedure of object;                              // ПРОЧИТАТЬ ПАРАМЕТРЫ НОВОГО ФЭУ
      OnPMTNewReadKTV       : procedure of object;                              // ПРОЧИТАТЬ КТВ
      //OnScanBoardStartRead  : procedure of object;                              // ЗАПУСК ЧТЕНИЯ ШТРИХКОДА
      OnScanBoardReadBase   : procedure of object;                              // ПРОЧИТАТЬ СОСТОЯНИЕ ГОТОВНОСТИ ВЫПОЛНЕНИЯ ЧТЕНИЯ ШТРИХКОДА
      OnScanBoardReadBarCode: procedure of object;                              // После ЧТЕНИЯ ШТРИХКОДА

      OnSuccesExecute       : procedure of object;                              // При успешном ответе на команду из алгоритмической серии (отмечены буквами)
      OnPMTNewGetDevNumber  : procedure of object;                              // При чтениее номера устройства
      OnReceiveTemp         : procedure of object;                              //
      OnReceiveResults      : procedure of object;                              //
      OnGetPanelCommand     : procedure(aCmd: word) of object;                  // После прихода команды от панели
      OnPanelDisconnect     : procedure(aDisconnectType: word) of object;       // После прихода команды от панели

      OnTLDError            : procedure (Error: boolean) of object;             // передача состояния ошибки на форму
      OnTLDMeasuring        : procedure (aTLDDetsMeas: boolean) of object;      // измерение детекторов
      OnReceiveModBusExchange: TModBusExchange;
      OnCommandLog           : TCommandLog;


      //Технологическое, для работы алгоритмов
      const
        cMaxStartMeasureTemp = 80{70};  //  максимальное значение температуры печки при котором можно начинать измерение
        cMinFlow = 100; // если прокачка нагретым воздухом в процессе измерения меньше - измерение должно остановиться
        AccidentCaption: array [TAccident] of string = ('Low Flow','Unknown Message');

      //property OnConnectionState: TConnectionState read FOnConnectionState write SetOnConnectionState;
      //property OnTLDError: TTLDError read FOnTLDError write SetOnTLDError;
      //property OnTLDMeasuring: TTLDMeasuring read FOnTLDMeasuring write SetOnTLDMeasuring;

      //property MeasurePos: integer read FMeasurePos write SetMeasurePos;
      //property StartMeasuringFlag: boolean read FStartMeasuringFlag write SetStartMeasuringFlag;
      procedure LogModBusExchange(Log: String);                 // отображение всех пакетов (modbus-обмен)
      procedure LogCommand(Time, Msg, Inf: String; MsgType, MsgPriority: integer);  // запросы/ответы команд

      procedure SaveCallParams(Params: String; Tag: Int64);  // Процедура сохранения входных параметров команд (добавляется во все команды)
      procedure ClearCallParams;  // Процедура очистки входных параметров команд


// настройки порта
      property COM: String read FCOM write SetCOM;
      property ConnectedPort: boolean read FConnectedPort write FConnectedPort;
      property Emulator: boolean read FEmulator write FEmulator;

      constructor Create(aStartCOM: String; aStartBaudRate: integer; aStartStopBits: integer; aStartParity: integer; aStartByteSize: integer);
      destructor Destroy; override;
      function CmdIsDone: boolean;                             // сотояние команды выполнена/не выполнена

      procedure NNStopMeasuring;                               //   - СТОП ИЗМЕРЕНИЙ
      procedure NNAccident(anAccident: TAccident);             // Уведомление об аварийной ситуации

// MotorsBoard (Управление шаговыми движками и цифровой вход/выход (контроль положения кассетниц и тп))
      procedure NNMotorsStop(aMotorID: integer);                  //  - Аварийная остановка шагового двигателя
      procedure NNMotorsInit(aMotorID: integer);                  //  - Инициализация шагового двигателя
      procedure NNMotorsReadRWParams1;                            //  СЧИТЫВАНИЕ ЗАПИСЫВАЕМЫХ ПАРАМЕТРОВ МОТОРНОГО БЛОКА (регистры 40-46)
      procedure NNMotorsReadRWParams2;                            //  СЧИТЫВАНИЕ ЗАПИСЫВАЕМЫХ ПАРАМЕТРОВ МОТОРНОГО БЛОКА (регистры 101-180)
      //procedure NNMotorsPowerLine1On;                             //  - Включить линию питания 1
      //procedure NNMotorsPowerLine1Off;                            //  - Выключить линию питания 1
      //procedure NNMotorsPowerLine2On;                             //  - Включить линию питания 2
      //procedure NNMotorsPowerLine2Off;                            //  - Выключить линию питания 2
      procedure NNMotorsWriteDigitalOutput(aOutputs: word);       //  - Позиционирование шагового двигателя
      procedure NNMotorsWriteParams4One(aMotorID: integer);
      procedure NNMotorsWriteStatParams;
      procedure NNMotorsWriteEEPROM;

      // вспомогательные команды (для внутреннего использования универсальными командами)
      procedure NNMotorsSetPosition    (Tag,aMotorID,aPosition: Int64);  //  - Позиционирование шагового двигателя
      procedure NNMotorsReadProgress   (Tag,aMotorID: Int64);            //  - чтение процента выполнения команды

      // универсальные команды (Tag=cRunCommand - для серий команд, Tag=cRunSingle - для одиночной команды)
      procedure NNMotors_GetDeviceID_CS   (Params: String; Tag: Int64);  // Чтение номера устройства из моторной платы
      procedure NNMotors_ReadBase_CS      (Params: String; Tag: Int64);  //  - Опрос состояния моторов
      procedure NNMotors_Init1_251_CS     (Params: String; Tag: Int64);  //  - Инициализация шагового двигателя 1 этап 2
      procedure NNMotors_Init1_252_CS     (Params: String; Tag: Int64);  //  - Инициализация шагового двигателя 1 этап 3
      procedure NNMotors_Init1_253_CS     (Params: String; Tag: Int64);  //  - Инициализация шагового двигателя 1 этап 1
      procedure NNMotors_Init2_253_CS     (Params: String; Tag: Int64);  //  - Инициализация шагового двигателя 2
      procedure NNMotors_Init3_253_CS     (Params: String; Tag: Int64);  //  - Инициализация шагового двигателя 3
      procedure NNMotors_Init4_253_CS     (Params: String; Tag: Int64);  //  - Инициализация шагового двигателя 4
      procedure NNMotors_Init5_253_CS     (Params: String; Tag: Int64);  //  - Инициализация шагового двигателя 5
      procedure NNMotors_PL1On_CS         (Params: String; Tag: Int64);  //  - Включить линию питания 1
      procedure NNMotors_PL1Off_CS        (Params: String; Tag: Int64);  //  - Выключить линию питания 1
      procedure NNMotors_PL2On_CS         (Params: String; Tag: Int64);  //  - Включить линию питания 2
      procedure NNMotors_PL2Off_CS        (Params: String; Tag: Int64);  //  - Выключить линию питания 2
      procedure NNMotors_PL3On_CS         (Params: String; Tag: Int64);  //  - Включить линию питания 3
      procedure NNMotors_PL3Off_CS        (Params: String; Tag: Int64);  //  - Выключить линию питания 3
      procedure NNMotors_PosMonitoring_CS (Params: String; Tag: Int64);  // ШД1 в положение 1 каждые 20 проходов
      procedure NNMotors_Go1To1_CS        (Params: String; Tag: Int64);  // ШД1 в положение 1
      procedure NNMotors_Go1To2_CS        (Params: String; Tag: Int64);  // ШД1 в положение 2
      procedure NNMotors_Go1To3_CS        (Params: String; Tag: Int64);  // ШД1 в положение 3
      procedure NNMotors_Go1To4_CS        (Params: String; Tag: Int64);  // ШД1 в положение 4
      procedure NNMotors_Go1To5_CS        (Params: String; Tag: Int64);  // ШД1 в положение 5
      procedure NNMotors_Go1To6_CS        (Params: String; Tag: Int64);  // ШД1 в положение 6
      procedure NNMotors_Go2To1_CS        (Params: String; Tag: Int64);  // ШД2 в положение 1
      procedure NNMotors_Go2To2_CS        (Params: String; Tag: Int64);  // ШД2 в положение 2
      procedure NNMotors_Go3To1_CS        (Params: String; Tag: Int64);  // ШД3 в положение 1
      procedure NNMotors_Go3To2_CS        (Params: String; Tag: Int64);  // ШД3 в положение 2
      procedure NNMotors_Go4To1_CS        (Params: String; Tag: Int64);  // ШД4 в положение 1
      procedure NNMotors_Go4To2_CS        (Params: String; Tag: Int64);  // ШД4 в положение 2
      procedure NNMotors_Go5To1_CS        (Params: String; Tag: Int64);  // ШД5 в положение 1
      procedure NNMotors_Go5To2_CS        (Params: String; Tag: Int64);  // ШД5 в положение 2

// AirHeatBoard  (Нагреватель)  (две версии в режиме совместимости)
      procedure NNAirHeatReadAll; // Чтение параметров AirHeatBoard +New
      procedure NNAirHeatWriteStatus(aHeatStatus: word);                 // Only OLD Version (в новой версии нет такого параметра)

      // вспомогательные команды (для внутреннего использования универсальными командами)
      procedure NNAirHeatWriteProfile     (Tag: Int64; aMode, aPreHeatTemp,aPreHeatRate,aPreHeatTime,aHeatTemp,aHeatRate,aHeatTime : string); // Запись термопрофиля +New
      procedure NNAirHeat_ReadTempInKTV_CS(Tag: Int64);                  // A5_inKTV // Чтение (температур) с последующим опросом КТВ (только при измерении) +New

      // универсальные команды (Tag=cRunCommand - для серий команд, Tag=cRunSingle - для одиночной команды)
      procedure NNAirHeat_ReadHolding_CS  (Params: String; Tag: Int64);  // Чтение параметров AirHeatBoard New - Holding Registers //Only New
      procedure NNAirHeat_ReadInput_CS    (Params: String; Tag: Int64);  // Чтение параметров AirHeatBoard New - Input Registers //Only New
      procedure NNAirHeat_Stop_CS         (Params: String; Tag: Int64);  // Принудительная остановка измерения
      procedure NNAirHeat_WriteProfMeas_CS(Params: String; Tag: Int64);  // Запись профиля из карты пользовательских параметров по текущему детектору
      procedure NNAirHeat_ReadTemp_CS     (Params: String; Tag: Int64);  // Команда чтения
      procedure NNAirHeat_Start_CS        (Params: String; Tag: Int64);  // Старт измерения
      procedure NNAirHeat_WriteProfBurn_CS(Params: String; Tag: Int64);  // Запись профиля отжига из карты пользовательских параметров по текущему детектору
      procedure NNAirHeat_CoolingDown_CS  (Params: String; Tag: Int64);  // Ожидание остывания
      procedure NNAirHeat_CheckAir_CS     (Params: String; Tag: Int64);  // Загрузить пустой термопрофиль для проверки потока воздуха

      // MonitorBoard
      //procedure NNMonitorReadAll;
      //procedure NNMonitorWriteAll(aTargetTemperature,aRLCIntencity1,aRLCIntencity2,aRLCIntencity3,aRLCIntencity4: string);
      //procedure NNMonitorInit; // LED off
      //
      //procedure NNMonitorM1(Params: String; Tag: Int64); // M1
      //procedure NNMonitorM2(Params: String; Tag: Int64); // M2
      //procedure NNMonitorM3(Params: String; Tag: Int64); // M3
      //procedure NNMonitorM4(Params: String; Tag: Int64); // M4 - инициализация элемента Пельтье

      // PMTBoard
      //procedure NNPMTBoardReadAll;
      //procedure NNPMTBoardWriteAll(aCounterTriggering,aHVFineAdjustment1,aHVFineAdjustment2,aPreheatTime,aMeasureTime: string);
      //
      //procedure NNPMTBoardP1(Params: String; Tag: Int64); // P1

      //// PMTNew
      //procedure NNPMTNewReadBase;
      //procedure NNPMTNewReadNumChan;
      //procedure NNPMTNewReadKTV;
      //procedure NNPMTNewSetTime;
      //procedure NNPMTNewStart;
      //
      //procedure NNPMTNewPN1(Params: String; Tag: Int64); // Ping
      //procedure NNPMTNewPN2(Params: String; Tag: Int64); // Set Time and start
      //procedure NNPMTNewPN3(Params: String; Tag: Int64); // Start Read KTV

// PMT (Контроль ФЭУ + управление светодиодами и элементом Пельтье (вторая ревизия новой версии))
      procedure NNPMTReadKTV(Tag: Int64);                                // Вычитываем КТВ
      procedure NNPMTSwitch(SubdeviceNum: integer; State: byte);         // State=1 Включить, State=0 выключить LED или элемент Пельтье (1-Led1, 2-Led2, 3- Пельтье)
      procedure NNPMTTargetTemp(Temp:single);                            // Установка целевой температуры (если Tag=1, то установка из Params)
      procedure NNPMTSetControlTime(aTime:word);                         // Установка времени контроля темнового тока и тока от источника
      procedure NNPMTSetDevNumber(aNumber:DWord);                        // Установка доп. номера установки - не используется
      procedure NNPMTGetDevNumber;                                       // Чтение доп. номера установки - не используется
      procedure NNPMTStart(Tag: Int64);                                  // Старт измерения и чтения

      procedure NNPMT_ReadProgress_CS (Tag: Int64);                       //  - чтение процента выполнения команды

      // универсальные команды (Tag=cRunCommand - для серий команд, Tag=cRunSingle - для одиночной команды)
      procedure NNPMT_ReadChannels_CS     (Params: String; Tag: Int64);  // Читаем число каналов в PMT и если оно не 300 - вычитываем КТВ (Старт чтения)
      procedure NNPMT_ReadBase_CS         (Params: String; Tag: Int64);  // Чиение всего - ОК
      procedure NNPMT_SetTime_CS          (Params: String; Tag: Int64);  // Устанавливаем время выполнения профиля в плату PMT
      procedure NNPMT_DarkCurStart_CS     (Params: String; Tag: Int64);  // Запуск измерения темнового тока
      procedure NNPMT_SrcCurStart_CS      (Params: String; Tag: Int64);  // Запуск измерения тока от контрольного источника
      procedure NNPMT_SetPeltierTemp_CS   (Params: String; Tag: Int64);  // Установка целевой температуры (из ini)

// ScanBoard (Сканер штрихкодов)
      //procedure NNScanBoardReadBase;
      //procedure NNScanBoardStartRead;
      //procedure NNScanBoardReadBarCode;

      procedure NNScan_ReadBase_CS        (Params: String; Tag: Int64); // S1 - Read Base
      procedure NNScan_Start_CS           (Params: String; Tag: Int64); // S2 - Start Read
      procedure NNScan_ReadBarCode_CS     (Params: String; Tag: Int64); // S3 - Read BarCode

// UserPanel (Встроенная панель)
     // Процедуры обмена с панелью
      procedure NNUserPanelReadBase;  // Чтение параметров из панели с 0 регистра
      procedure NNUserPanelWrite1000; // Запись параметров в панель с 1000 регистра

      // универсальные команды (Tag=cRunCommand - для серий команд, Tag=cRunSingle - для одиночной команды)
      procedure NNPanel_WinBase_CS        (Params: String; Tag: Int64); // Установить основное окно
      procedure NNPanel_WinMotors_CS      (Params: String; Tag: Int64); // Установить окно с моторами
      procedure NNPanel_WinScan_CS        (Params: String; Tag: Int64); // Установить окно с дозиметром и проверками
      procedure NNPanel_WinKTV1_CS        (Params: String; Tag: Int64); // Установить окно с чтением первой пары КТВ
      procedure NNPanel_WinKTV2_CS        (Params: String; Tag: Int64); // Установить окно с чтением второй пары КТВ
      procedure NNPanel_WinPowerOff_CS    (Params: String; Tag: Int64); // Установить окно выхода и обесточивания


      procedure SetQueryEmulator;                              // инициализация таймера эмуляции

      procedure ReinitializationPort;

      // перенос в Public в связи с выносом части логики в модуль TLDCommandSeries
      procedure ComPortFaultLog(aConnected: boolean);
      procedure OnUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
      procedure WatchdogTimerTick(Sender: TObject);        // проверка состояния связи и автоматическое восстановление порта при сбое
  end;

const
// КОМАНДЫ ДЛЯ ДОЗА ТЛД АВТО

// MotorsBoard - плата управления шаговыми движками (MODBUS адрес = $01)
  cMotorsGetDeviceID          = '01 03 00AE 0001';             //  Чтение номкра установки
  cMotors_ReadBase            = '01 03 0000 0017';             //  СЧИТЫВАНИЕ ОСНОВНЫХ ЧИТАЕМЫХ ДАННЫХ МОТОРНОГО БЛОКА (первые 22 регистра)
  cMotorsReadRWParams1        = '01 03 0028 0007';             //  СЧИТЫВАНИЕ ЗАПИСЫВАЕМЫХ ПАРАМЕТРОВ МОТОРНОГО БЛОКА (регистры 40-46)
  cMotorsReadRWParams2        = '01 03 0065 0051';             //  СЧИТЫВАНИЕ ЗАПИСЫВАЕМЫХ ПАРАМЕТРОВ МОТОРНОГО БЛОКА (регистры 101-180)
  cMotorsSetPoint             = '01 06 %4.4X %4.4X';           //  ПОЗИЦИОНИРОВАНИЕ МОТОРНОГО БЛОКА + (ADDR = MotorNumber+40) + (Num=PointNumber)
  cMotorsReadProgress         = '01 03 %4.4X 0003';            //  ЧТЕНИЕ ПРОГРЕССА ВЫПОЛНЕНИЯ КОМАНДЫ + (ADDR = 3*MotorNumber+1)
  cMotorsStop                 = '01 06 %4.4X 00FE';            //  СТОП МОТОРНОГО БЛОКА + (ADDR = MotorNumber+40)
  cMotorsInit                 = '01 06 %4.4X 00FD';            //  ИНИЦИАЛИЗАЦИЯ МОТОРНОГО БЛОКА + (ADDR = MotorNumber+40)
  cMotorsInit1_251            = '01 06 0028 00FB';             //  ИНИЦИАЛИЗАЦИЯ 251 МОТОРНОГО БЛОКА ШД1
  cMotorsInit1_252            = '01 06 0028 00FC';             //  ИНИЦИАЛИЗАЦИЯ 252 МОТОРНОГО БЛОКА ШД1
  cMotorsInit1_253            = '01 06 0028 00FD';             //  ИНИЦИАЛИЗАЦИЯ 253 МОТОРНОГО БЛОКА ШД1
  cMotorsInit2_253            = '01 06 0029 00FD';             //  ИНИЦИАЛИЗАЦИЯ 253 МОТОРНОГО БЛОКА ШД2
  cMotorsInit3_253            = '01 06 002A 00FD';             //  ИНИЦИАЛИЗАЦИЯ 253 МОТОРНОГО БЛОКА ШД3
  cMotorsInit4_253            = '01 06 002B 00FD';             //  ИНИЦИАЛИЗАЦИЯ 253 МОТОРНОГО БЛОКА ШД4
  cMotorsInit5_253            = '01 06 002C 00FD';             //  ИНИЦИАЛИЗАЦИЯ 253 МОТОРНОГО БЛОКА ШД5
  cMotorsPowerLine1On         = '01 06 002E 0001';             //  Включить линию 1
  cMotorsPowerLine1Off        = '01 06 002E 0002';             //  Выключить линию 1
  cMotorsPowerLine2On         = '01 06 002E 0003';             //  Включить линию 2
  cMotorsPowerLine2Off        = '01 06 002E 0004';             //  Выключить линию 2
  cMotorsPowerLine3On         = '01 06 002E 0006';             //  Включить линию 3 // инверсия, так как инверсное реле
  cMotorsPowerLine3Off        = '01 06 002E 0005';             //  Выключить линию 3 // инверсия, так как инверсное реле
  cMotorsWriteDigitalOutput   = '01 06 0015 %4.4X';            //  Установить дискретные значения на цифровом выходе
  cMotorsWriteParams4One      = '01 10 %4.4X 000B 16 %4.4X  %4.4X %4.4X %4.4X %4.4X  %4.4X %4.4X %4.4X %4.4X %4.4X'; //  Записать шаги констант в ШД
  cMotorsWriteStatParams      = '01 10 00AE 0007 0E %4.4X  %4.4X %4.4X %4.4X %4.4X  %4.4X %4.4X'; //  Записать статистические параметры
  cMotorsWriteEEPROM          = '01 06 00AD 0001';             //  Записать настроечные параметры в EEPROM
  // другие команды формируются через функции

// AirHeatBoard     - плата управления нагревателем газа (MODBUS адрес = $20)
  cAirHeatReadAll_Old         = '20 03 0000 0011';             //  СЧИТЫВАНИЕ ВСЕХ ДАННЫХ НАГРЕВАТЕЛЬНОГО БЛОКА
  cAirHeatWriteProfile_Old    = '20 10 000A 0007 0E  %4.4X %4.4X %4.4X %4.4X %4.4X %4.4X %4.4X'; //  ЗАПИСЬ ПРОФИЛЯ
  cAirHeatWriteStatus_Old     = '20 06 0009 %4.4X';            //  ЗАПИСЬ СТАТУСА
  cAirHeatA1_Old              = '20 03 0000 0011';             //  Команда чтения
  cAirHeat_Start_Old          = '20 06 0009 0880';             //  Старт измерения
  cAirHeat_Stop_Old           = '20 06 0009 FFFF';             //  Принудительная остановка измерения

  cAirHeat_ReadInput          = '20 04 0000 000B';             //  Cчитывание всех данных нагревательного блока
  cAirHeat_ReadHolding        = '20 03 0000 0008';             //  Считывание всех данных нагревательного блока (Holding - регистры)
  cAirHeatWriteProfile        = '20 10 0000 0006 0C  %4.4X %4.4X %4.4X %4.4X %4.4X %4.4X'; //  ЗАПИСЬ ПРОФИЛЯ
  cAirHeat_Start              = '20 10 0006 0002 04  %4.4X 0001';   //  Старт измерения
  cAirHeat_Stop               = '20 06 0007 0000';             //  Принудительная остановка измерения

  cStopMeasuring              = '20 03 0009 FFFF';             //  АВАРИЙНЫЙ СТОП НАГРЕВА (AirHeatWriteEmergencyStop)     //  ПРЕРВАТЬ ИЗМЕРЕНИЕ (остановить нагрев)

// PMT         - новая плата считывания ФЭУ (MODBUS адрес = $0A) mode 2
  cPMT_ReadBase               = '0A 03 0000 001D';             //  СЧИТЫВАНИЕ БАЗОВЫХ ДАННЫХ ФЭУ New
  cPMT_ReadNumChan            = '0A 03 0004 0002';             //  СЧИТЫВАНИЕ ЧИСЛА ТЕКУЩИХ ДАННЫХ ИЗ ФЭУ MB_REG_MEASURE_NUM_CH1 + MB_REG_MEASURE_NUM_CH2
  cPMT_ReadKTV                = '0A 03 %4.4X %4.4X';           //  СЧИТЫВАНИЕ КТВ
  cPMT_Start                  = '0A 06 0007 0001';             //  СТАРТ
  cPMT_SetTime                = '0A 06 0006 %4.4X';            //  УСТАНОВКА ВРЕМЕНИ и СТАРТ
  cPMT_Switch                 = '0A 06 %4.4X %4.4X';           //  Включить - выключить LED или элемент Пельтье 1-Led1, 2-Led2, 3- Пельтье
  cPMT_DarkCurStart           = '0A 06 0008 0001';             // Запуск измерения темнового тока
  cPMT_SrcCurStart            = '0A 06 0009 0001';             // Запуск измерения тока от контрольного источника
  cPMT_SetTargetTemp          = '0A 10 0018 0002 04 %4.4X %4.4X'; // Установка Температуры для Пельтье
  cPMT_SetControlTime         = '0A 06 001B %4.4X';            // Установка времени котроля токов (темнового и от источника)
  cPMT_SetDevNumber           = '0A 10 0968 0002 04 %8.8X';    // Установка номера установки
  cPMT_GetDevNumber           = '0A 03 0968 0002';             // Чтение номера установки

// ScanBoard        - плата сканера штрихкода (MODBUS адрес = $60)
  cScaner_StartRead           = '60 06 0000 0001';             //  СТАРТ ДЕТЕКТИРОВАНИЯ ШТРИХКОДА
  cScaner_ReadBase            = '60 03 0001 0003';             //  СЧИТЫВАНИЕ ГОТОВНОСТИ ДЕТЕКТИРОВАНИЯ ШТРИХКОДА
  cScaner_ReadBarCode         = '60 03 0004 %4.4X';            //  СЧИТЫВАНИЕ ШТРИХКОДА
  cScanBoardS1                = '60 03 0001 0003';             //  Команда чтения
  cScanBoardS2                = '60 06 0000 0001'; //'60 10 00 00 00 01 02 00 01';  //  Начать считывание штрихкода
  cScanBoardS3                = '60 03 0004 %4.4X';            //  Считывание штрихкода известной длины

// ТИПЫ СООБЩЕНИЙ
  cMsgRead                = 0;   //  сообщения об отправке команд
  cMsgCommand             = 1;   //  сообщения о выполнении команд
  cMsgEngine              = 2;   //  сообщения о состоянии ШД
  cMsgStove               = 3;   //  сообщения о состоянии печки
  cMsgConnect             = 4;   //  сообщения о состоянии связи с устройством
  cMsgCRC                 = 5;   //  сообщения о ошибке CRC
  cMsgInf                 = 6;   //  информационные сообщения
  cMsgBigDose             = 7;   //  признак обнаружения большой дозы
  cMsgNone                = 255; //  без категории, например тип для маскирования ошибки (здесь для сообщения "Ошибка механики")
// ПРИОРИТЕТЫ СООБЩЕНИЙ
  cMsgPriorityInf         = 0;
  cMsgPriorityWarning     = 1;
  cMsgPriorityError       = 2;
var
  emAnswer1: array [0..14] of integer = (10, 3, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 103, 252, 25);
  emAnswer2: array [0..14] of integer = (10, 3, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 165, 252, 25);

implementation
uses Math,uTimerMessages;

function TTLD_Auto.ConvertToWord(Byte_1, Byte_2: Byte): Word;  // функция для перевода бйтов в integer
var
  arr : TArrayToInteger;
begin
  arr.ArrayBuff[0]:=0;
  arr.ArrayBuff[1]:=0;
  arr.ArrayBuff[2]:=0;
  arr.ArrayBuff[3]:=0;
  arr.ArrayBuff[4]:=0;
  arr.ArrayBuff[5]:=0;
  arr.ArrayBuff[6]:=0;
  arr.ArrayBuff[7]:=0;

  arr.ArrayBuff[0]:= Byte_1;
  arr.ArrayBuff[1]:= Byte_2;

  Result:=arr.I;

end;

function TTLD_Auto.ConvertToDWord(Byte_1, Byte_2, Byte_3, Byte_4: Byte): DWord;  // функция для перевода бйтов в integer
var
  arr : TArrayToInteger;
begin
  arr.ArrayBuff[0]:=0;
  arr.ArrayBuff[1]:=0;
  arr.ArrayBuff[2]:=0;
  arr.ArrayBuff[3]:=0;
  arr.ArrayBuff[4]:=0;
  arr.ArrayBuff[5]:=0;
  arr.ArrayBuff[6]:=0;
  arr.ArrayBuff[7]:=0;

  arr.ArrayBuff[0]:= Byte_1;
  arr.ArrayBuff[1]:= Byte_2;
  arr.ArrayBuff[2]:= Byte_3;
  arr.ArrayBuff[3]:= Byte_4;

  Result:=arr.I;

end;

function TTLD_Auto.ConvertToDWord2(Byte_1, Byte_2, Byte_3, Byte_4: Byte): DWord;  // функция для перевода бйтов в integer
var
  arr : TArrayToInteger;
begin
  arr.ArrayBuff[0]:=0;
  arr.ArrayBuff[1]:=0;
  arr.ArrayBuff[2]:=0;
  arr.ArrayBuff[3]:=0;
  arr.ArrayBuff[4]:=0;
  arr.ArrayBuff[5]:=0;
  arr.ArrayBuff[6]:=0;
  arr.ArrayBuff[7]:=0;

  arr.ArrayBuff[0]:= Byte_2;
  arr.ArrayBuff[1]:= Byte_1;
  arr.ArrayBuff[2]:= Byte_4;
  arr.ArrayBuff[3]:= Byte_3;

  Result:=arr.I;

end;

function TTLD_Auto.ConvertToInt64(Byte_1, Byte_2, Byte_3, Byte_4, Byte_5, Byte_6, Byte_7, Byte_8: Byte): Int64;  // функция для перевода бйтов в integer
var
  arr : TArrayToInteger;
begin
  arr.ArrayBuff[0]:=0;
  arr.ArrayBuff[1]:=0;
  arr.ArrayBuff[2]:=0;
  arr.ArrayBuff[3]:=0;
  arr.ArrayBuff[4]:=0;
  arr.ArrayBuff[5]:=0;
  arr.ArrayBuff[6]:=0;
  arr.ArrayBuff[7]:=0;

  arr.ArrayBuff[0]:= Byte_1;
  arr.ArrayBuff[1]:= Byte_2;
  arr.ArrayBuff[2]:= Byte_3;
  arr.ArrayBuff[3]:= Byte_4;
  arr.ArrayBuff[4]:= Byte_5;
  arr.ArrayBuff[5]:= Byte_6;
  arr.ArrayBuff[6]:= Byte_7;
  arr.ArrayBuff[7]:= Byte_8;
  Result:=arr.I;

end;

function TTLD_Auto.ConvertSingleToSingle(aSingle: Single): Single;  // функция для переворачивания байтов Single
var
  arr : TArrayToInteger;
  T: byte;
begin
  arr.R:= aSingle;

  T := arr.ArrayBuff[0];
  arr.ArrayBuff[0] := arr.ArrayBuff[3];
  arr.ArrayBuff[3] := T;

  T := arr.ArrayBuff[1];
  arr.ArrayBuff[1] := arr.ArrayBuff[2];
  arr.ArrayBuff[2] := T;


  Result:=arr.R;
end;

function TTLD_Auto.ConvertSingleToSingle2(aSingle: Single): Single;  // функция для переворачивания байтов Single
var
  arr : TArrayToInteger;
  T: byte;
begin
  arr.R:= aSingle;
//
//    T := arr.ArrayBuff[0];
//    arr.ArrayBuff[0] := arr.ArrayBuff[1];
//    arr.ArrayBuff[1] := T;
//
//    T := arr.ArrayBuff[3];
//    arr.ArrayBuff[3] := arr.ArrayBuff[2];
//    arr.ArrayBuff[2] := T;

  T := arr.ArrayBuff[0];
  arr.ArrayBuff[0] := arr.ArrayBuff[2];
  arr.ArrayBuff[2] := T;

  T := arr.ArrayBuff[1];
  arr.ArrayBuff[1] := arr.ArrayBuff[3];
  arr.ArrayBuff[3] := T;

  Result:=arr.R;
end;


function TTLD_Auto.ByteToWord(aData: {RBuff}array of byte; aLast: integer): WORD;
// функция преобразования принятого CRC в формат WORD, last - номер последнего байта в принятом CRC
begin
  Result := 256 * aData[aLast] + aData[aLast - 1];
end;

function TTLD_Auto.ByteToWord2(aData: {RBuff}array of byte; aLast: integer): WORD;
// функция преобразования принятого CRC в формат WORD, last - номер последнего байта в принятом CRC
begin
  Result := 256 * aData[aLast-1] + aData[aLast];
end;

function TTLD_Auto.StringToArray(aBody: String; var aCountBytes: integer
  ): Rbuff;
var
  Bytes, i: integer;
  StringBody, AnotherStringBody: String;
begin
  try
    StringBody:='';
    Bytes := 0;
    for i := 1 to length(aBody) + 1 do      // ТУТ ОШИБКА
    begin
      if (i<=length(aBody)) and (aBody[i] <> #0) and (aBody[i] <> ' ') then // проверяем на наличие пробелов и конца сторки
        StringBody := StringBody + aBody[i] // если в строке нет пробелов и это не конец строки, то все значения пишем в StringBody
      else
      begin
        if (length(StringBody) > 2) then // если в StringBody>2 элементов разбиваем по 2 элемента и пишем в массив
        begin
          while length(StringBody) > 1 do
          begin
            AnotherStringBody := copy(StringBody, 1, 2);
            Delete(StringBody, 1, length(AnotherStringBody));
            Result[Bytes] := StrToInt('$' +AnotherStringBody);
            inc(Bytes);
          end;
        end;
        if not(StringBody = '') then
        begin
          if length(StringBody) = 1 then
          begin
            Result[Bytes] := StrToInt('$' +StringBody);
            StringBody := StringBody
          end
          else
          begin
            Result[Bytes] := StrToInt('$' +StringBody);
            StringBody := '';
            inc(Bytes);
          end;
        end;
      end;
    end;
    aCountBytes := Bytes;
  except
    raise Exception.Create('Не корректные данные');
  end;
end;

function TTLD_Auto.CalculateModBusCRC(aData: array of byte; aBytes: integer):word;
var
  crc: word;
  sh,i: integer;
  item: byte;
begin
  crc := $FFFF;
  for i:=0 to aBytes-1 do
  //for item in aData do
  begin
    crc := crc xor (aData[i]);
    //crc := crc xor item;
    sh:=0;
    while sh<>8 do
      if (crc and 1)<>0
      then
      begin
        crc:=(crc shr 1) xor $A001;
        sh:=sh+1;
      end
    else
    begin
      crc:=crc shr 1;
      sh:=sh+1;
    end;
  end;
  result:=crc;
end;

function TTLD_Auto.MakeStringModBusPacket(PacketWithCRC: RBuff; CountBytesToWrite: integer): String;
var
  i: integer;
  St: String;
begin
  for i := 0 to CountBytesToWrite-1 do
  begin
    St:=St+' '+IntToHex(PacketWithCRC[i],2);
  end;
  Result:=St;
end;

function TTLD_Auto.CmdIsDone: boolean;
begin
//  if (StateCommand = cCmdDone) or (StateCommand = cCmdStop) or (StateCommand = 0) then
  if (StateCommand = 0) then
    result := true
  else
    result := false;
end;

constructor TTLD_Auto.Create(aStartCOM: String; aStartBaudRate: integer; aStartStopBits: integer; aStartParity: integer; aStartByteSize: integer);
var
  i: integer;
  b: integer;
begin
  inherited Create;

  isFirstTimeStart:=false;
  FCOMPortFaultFlag:=true;
  FLastSendedPacket:='';
  SendPacketTime:=Now;
  WritePacketActive:=false;
  TLDReset:=false;
  LastParams:='';
  LastTag   :=0;
  //ReceivePacketActive:=true;

  // Translator Server
  TransServer:=TIdUDPServer.Create(Nil);
  TransServer.DefaultPort:=cTranslatorPort;
  TransServer.OnUDPRead:=@OnUDPRead;
  TransServer.Active:=True;

  IsTranslatorServer:= false;
  if Pos(cTranslatorServer,aStartCOM)>0 then
  begin
    aStartCOM:=StringReplace(aStartCOM,cTranslatorServer,'',[]);
    //TransServer:=TIdUDPServer.Create(Nil);
    //TransServer.DefaultPort:=cTranslatorPort;
    //TransServer.OnUDPRead:=@OnUDPRead;
    //TransServer.Active:=True;
    IsTranslatorServer:= true;
    Host:='127.0.0.1';
  end;

  // Translator Client
  IsTranslatorClient:= false;
  if Pos(cTranslatorClient,aStartCOM)>0 then
  begin
    aStartCOM:=StringReplace(aStartCOM,cTranslatorClient,'',[]);
    //TransServer:=TIdUDPServer.Create(Nil);
    //TransServer.DefaultPort:=cTranslatorPort;
    //TransServer.OnUDPRead:=@OnUDPRead;
    //TransServer.Active:=True;
    Host:=Trim(aStartCOM);
    IsTranslatorClient:= true;
  end;

  if aStartCOM <> cEmulator then
  begin
    WorkingTime:=0;
    SavedWorkingTime:=0;
//    FStoveCntWarning_MechanicsErr:=0;
    FCRCCntErr_MeasResult:=0;

    CNTQuery:=cCNTCommonNothing;
    //CNTResult:=cCNTReadMeasResultP0;

    CNTReadPositionErr:=0;

    PreviousCNTQuery:=cCNTCommonNothing;
    //PreviousCNTResult:=cCNTReadMeasResultP0;

    COMPortSyn:=TCOMPortSyn.Create;

    COMPortSyn.CP.Connect(aStartCOM);
    COMPortSyn.SetConfig(aStartBaudRate,aStartByteSize,aStartStopBits,cCOMPortParity);
    COMPortSyn.AsynchroOnReceiveModbus := @AsynchroOnReceiveModbus;

    if COMPortSyn.CP.LastError=0 then
    begin
      //COMPortSyn.Connected:=true;
      COMPortSyn.MyThread:=TMyThreadSyn.Create(COMPortSyn);

      FCOM:=aStartCOM;
      //FBaudRate:=aStartBaudRate;
      //FStopBits:=aStartStopBits;
      //FParity:=0;
      //FByteSize:=aStartByteSize;

      FConnectedPort:=true;

      //ID:=-1;

      //SetQuery;
      //AutoReadFlag:=True;
      //SendTime:=Now;
    end
    else
    begin
      //COMPortSyn.Connected:=false;

      FCOM:=aStartCOM;                 //||
      //FBaudRate:=aStartBaudRate;       //||
      //FStopBits:=aStartStopBits;       //||
      //FParity:=0;                      //||
      //FByteSize:=aStartByteSize;       //||

      FConnectedPort:=false;

      //SetQuery;                        //||
      //AutoReadFlag:=True;                //||
    //SendTime:=Now;                   //||
    end;

    // Периодическая проверка состояния связи с портом и автоматическое восстановление при сбое
    // (ранее восстановление было заглушкой - см. историю except-блока в TMyThreadSyn.Execute)
    FWatchdogTimer:=TTimer.Create(nil);
    FWatchdogTimer.Interval:=500;
    FWatchdogTimer.OnTimer:=@WatchdogTimerTick;
    FWatchdogTimer.Enabled:=true;
  end
  else
  begin
    FCOM:=aStartCOM;
    FEmulator:=true;
    SetQueryEmulator;
  end;

  ChangeData.DosimeterFound:=dsfNone;
  ChangeData.DetectorCount:=0;
  Panel.Output.DetectorsCount := 0;
  ChangeData.IsStopped:=false;
  Panel.DontUse := false;
  Motors.IgnoreAnswerError:=false;
  AirHeat.OldVersion:=True;

  LastMotorSet := 1;
  OnMotorsReadBase := Nil;
  OnMotorsReadProgress := Nil;
  OnMotorsSetPosition := Nil;
  OnMotorsStop := Nil;
  OnMotorsInit := Nil;
  OnMotorsReadRWParams1 := Nil;
  OnMotorsReadRWParams2 := Nil;
  OnSuccesExecute := Nil;
  OnPMTNewGetDevNumber := Nil;

  OnReceiveTemp := Nil;
  OnReceiveResults := Nil;
  OnGetPanelCommand := Nil;
  OnPanelDisconnect := Nil;

  StartTime:=0;
  DetNumber:=0;
  NoAnswerCount:=0;

  if not Assigned(ModbusClient) then ModbusClient := TIdModbusClient.Create;
  //ModbusClient.Host:='192.168.2.70';
  //ModbusClient.UnitID := 1;
  ModbusClient.BaseRegister:=0;
  //ModbusClient.TimeOut:=2500;
  //ModbusClient.
  ModbusClient.OnDisconnected:=@OnPanelFailure;
  ModbusClient.OnResponseError:=@OnPanelResponseError;
  //ModbusClient.OnResponseMismatch:=@OnPanelFailure;
end;

procedure TTLD_Auto.ReinitializationPort;
begin
  if Assigned(COMPortSyn) then FreeAndNil(COMPortSyn);

  COMPortSyn:=TCOMPortSyn.Create;
  //COMPortSyn.SetConfig(FBaudRate,FByteSize,FStopBits,cCOMPortParity);
  COMPortSyn.SetConfig(115200,8,1,cCOMPortParity);
  COMPortSyn.CP.Connect(FCOM);
  COMPortSyn.CP.GetErrorDesc(COMPortSyn.CP.LastError);

  if COMPortSyn.CP.LastError=0 then
  begin
    //COMPortSyn.Connected:=true;
    COMPortSyn.MyThread:=TMyThreadSyn.Create(COMPortSyn);
    FConnectedPort:=true;
  end
  else
  begin
    //COMPortSyn.Connected:=false;
    FConnectedPort:=false;
  end;
end;

procedure TTLD_Auto.WatchdogTimerTick(Sender: TObject);
begin
  // Срабатывает, только если фоновый поток обмена с портом реально зафиксировал
  // исключение (см. TMyThreadSyn.Execute) - в штатной работе это просто быстрый выход.
  if not Assigned(COMPortSyn) then Exit;
  if not Assigned(COMPortSyn.MyThread) then Exit;
  if not COMPortSyn.MyThread.HasConnectionFault then Exit;

  ComPortFaultLog(false); // фиксируем потерю связи в логе (метод уже был в проекте, но нигде не вызывался)

  ReinitializationPort;  // пересоздает COMPortSyn/MyThread; сама переинициализация не выполняется из фонового потока, только отсюда, из главного потока

  ComPortFaultLog(FConnectedPort); // если реконнект удался - зафиксирует восстановление связи; если нет - тихо промолчит до следующей попытки (дедупликация внутри ComPortFaultLog)
end;

destructor TTLD_Auto.Destroy;
begin
//  Timer.Free;
//  AnswerFlag:=false;
  //LogModBusExchange:=nil;
  //OnConnectionState:=nil;
  //LogCommand:=nil;
//  OnReinitialize:=nil;

  if Assigned(FWatchdogTimer) then
  begin
    FWatchdogTimer.Enabled:=false; // на случай, если Free сработает не мгновенно - чтобы таймер точно не тикнул во время разрушения объекта
    FreeAndNil(FWatchdogTimer);
  end;

  if Assigned(COMPortSyn) then
  begin
    //COMPortSyn.Connected:=false;
//    COMPortSyn.CP.CloseSocket;
//    COMPortSyn.CP.Free;
    COMPortSyn.Free;
  end;
  if Assigned(ModbusClient) then ModbusClient.Free;
  if Assigned(TransServer) then TransServer.Free;

  inherited;
end;

procedure TTLD_Auto.SetCOM(aCOMName: String);
begin
  FCOM:=aCOMName;
end;

//procedure TTLD_Auto.SetBaudRate(aBaudRate: integer);
//begin
//  FBaudRate:=aBaudRate;
//end;

//procedure TTLD_Auto.SetStartMeasuringFlag(aStartMeasuringFlag: boolean);
//begin
//  FStartMeasuringFlag:=aStartMeasuringFlag;
//  OnTLDMeasuring(aStartMeasuringFlag);
//end;

//procedure TTLD_Auto.SetStopBits(aStopBits: integer);
//begin
//  FStopBits:=aStopBits;
//end;

//procedure TTLD_Auto.SetParity(aParitye: integer);
//begin
//  FParity:=aParitye;
//end;

//procedure TTLD_Auto.SetByteSize(aByteSize: integer);
//begin
//  FByteSize:=aByteSize;
//end;

//procedure TTLD_Auto.SetOnModBusExchange(aOnModBusExchange: TModBusExchange);
//begin
//  FOnModBusExchange := aOnModBusExchange;
//
//  if COMPortSyn <> nil then
//  begin
//    if not Assigned(OnModBusExchange) then
//      COMPortSyn.AsynchroOnReceiveModbus := nil
//    else
//      COMPortSyn.AsynchroOnReceiveModbus := @AsynchroOnReceiveModbus;
//  end;
//end;

//procedure TTLD_Auto.SetOnCommandLog(aOnCommandLog: TCommandLog);
//begin
//  FOnCommandLog:=aOnCommandLog;
//end;

//procedure TTLD_Auto.SetOnConnectionState(aOnConnectionState: TConnectionState);
//begin
//  FOnConnectionState:=aOnConnectionState
//end;

//procedure TTLD_Auto.SetOnTLDError(aOnTLDError: TTLDError);
//begin
//  FOnTLDError:=aOnTLDError;
//end;

//procedure TTLD_Auto.SetOnTLDMeasuring(aOnTLDMeasuring: TTLDMeasuring);
//begin
//  FOnTLDMeasuring:=aOnTLDMeasuring;
//end;

//procedure TTLD_Auto.SetReinitialize(aOnReinitialize: TReinitialize);
//begin
//  FReinitializeTime:=Now;
//  FOnReinitialize:=aOnReinitialize;
//end;

procedure TTLD_Auto.PrepareModBusPacket(Packet: String; var aPacketWithCRC: RBuff; var aCountBytesToWrite: integer);
var
  i,
  CountBytesWithoutCRC,         //  количество байт в пакете без CRC
  CountBytesWithCRC: integer;   //  количество байт в пакете с CRC
  CalculateCRC: word;
  SendPacketArray: RBuff;
  CRC: packed array [0 .. 1] of byte absolute CalculateCRC;
  StringPacket: String;
begin
  FillChar(SendPacketArray, SizeOf(SendPacketArray), #0);
  FillChar(CRC, SizeOf(CRC), #0);
  try
    StringPacket := {IntToHex(Address, 2) +} Packet;
    SendPacketArray := StringToArray(StringPacket,CountBytesWithoutCRC); // преобразуем строку в массив фиксированной длинны (количество записываемых байт известно)
    CountBytesWithCRC := CountBytesWithoutCRC+2;  //  добавляем 2 байта для CRC
    aCountBytesToWrite := CountBytesWithCRC;
    for i := 0 to CountBytesWithoutCRC-1 do  // - 6 байт пакета без CRC переписывем в буфер для отсылки в порт
      aPacketWithCRC[i] :=SendPacketArray[i];
    CalculateCRC := CalculateModBusCRC(SendPacketArray,CountBytesWithCRC-2); // - вычитаем 2 т.к. байты CRC не должны войти
    for i := CountBytesWithoutCRC to CountBytesWithoutCRC+1 do // - 2 байта рассчитанного CRC дописываем в буфер для отсылки в порт
      aPacketWithCRC[i] := CRC[i-CountBytesWithoutCRC];
  except
    raise Exception.Create(rsErrCalcModBusCRC);
  end;
end;

procedure TTLD_Auto.OnPanelFailure(Sender: TObject);
begin
  if Assigned(OnPanelDisconnect) then OnPanelDisconnect(0);
end;

procedure TTLD_Auto.OnPanelResponseError(const FunctionCode: Byte;
  const ErrorCode: Byte; const ResponseBuffer: TModBusResponseBuffer);
begin
  if Assigned(OnPanelDisconnect) then OnPanelDisconnect(ErrorCode);
end;

procedure TTLD_Auto.LogModBusExchange(Log: String);
begin
  //Exit;

  //try
  if Assigned(OnReceiveModBusExchange) then OnReceiveModBusExchange(Log);
  //except
  //end;
end;

procedure TTLD_Auto.LogCommand(Time, Msg, Inf: String; MsgType,
  MsgPriority: integer);
begin
  try
    if Assigned(OnCommandLog) then OnCommandLog(Time, Msg, Inf, MsgType, MsgPriority);
  except
  end;
end;

procedure TTLD_Auto.SaveCallParams(Params: String; Tag: Int64);
begin
  LastParams:=Params;
  LastTag:=Tag;
end;

procedure TTLD_Auto.ClearCallParams;
begin
  LastTag:=cRunNone;
  LastParams:='';
end;

procedure TTLD_Auto.ModbusReadWriteComand_03_06_10(SendPacket: String);
const
  cSendWaitTimeoutMs = 2000; // максимальное время ожидания освобождения канала перед отправкой очередной команды, мс
var
  LocalPacketWithCRC     : RBuff;   // формируем пакет локально, а не пишем напрямую в поля потока - отдаем его целиком через PrepareSend
  LocalCountBytesToWrite : integer;
  stSendPacket        : string;
  size                : integer;
  res                 : string;
  ABytes              : TIdBytes;
  i                   : integer;
  WaitStart           : TDateTime;
begin
{
  if Emulator then
  begin
    case CNTQuery of // доделать при настройке эмулятора. А нужна такая громоздкая конструкция?
      cCNTStopMeas: ModbusReadWriteEmulator(cStopMeasuring);
      //cCNTMotors_ReadBase_CS: TLDAnswer(EmulatorAnswer2,cEmulatorLenght);

    end;
    Exit;
  end;
}
  WaitStart:=Now;
  while COMPortSyn.MyThread.IsSendPending do
  begin
    Sleep(1);
    if MilliSecondsBetween(Now,WaitStart) > cSendWaitTimeoutMs then
    begin
      // Порт не освободился за отведенное время - не отправляем поверх незавершенной
      // передачи (раньше здесь было бесконечное ожидание, способное подвесить поток).
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsSendWaitTimeout,'',cMsgConnect,cMsgPriorityInf);
      Exit;
    end;
  end;

  FLastSendedPacket:=SendPacket;
  SendPacketTime:=Now;

  FillChar(LocalPacketWithCRC, SizeOf(LocalPacketWithCRC), #0);
  LocalCountBytesToWrite:=0;

  PrepareModBusPacket(SendPacket,LocalPacketWithCRC,LocalCountBytesToWrite);
  StSendPacket:=MakeStringModBusPacket(LocalPacketWithCRC,LocalCountBytesToWrite);

//  if Assigned(Timer) then Timer.Enabled:=False;

  sleep(10);

  try
    if Assigned(COMPortSyn) and not IsTranslatorClient then
    begin
      LogModBusExchange('-> '+StSendPacket);
      COMPortSyn.MyThread.PrepareSend(LocalPacketWithCRC,LocalCountBytesToWrite); // потокобезопасно передаем буфер на отправку фоновому потоку
    end
      else
        if IsTranslatorClient then // транслируем в компорт другого компа
        try
          SetLength(ABytes,LocalCountBytesToWrite);
          for i:=0 to LocalCountBytesToWrite-1 do
            ABytes[i]:=LocalPacketWithCRC[i];
          TransServer.SendBuffer(Host,cTranslatorPort,ABytes);
          LogModBusExchange('->> '+StSendPacket);
        except
        end;

  except
    on E: Exception do
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',E.Message,'',cMsgConnect,cMsgPriorityInf);
  end;

//  if Assigned(Timer) then Timer.Enabled:=True;
end;


procedure TTLD_Auto.ModbusReadWriteEmulator(SendPacket: String);
var
  aPacketWithCRC: RBuff;
  aCountBytesToWrite: integer;
  StSendPacket: String;
begin
  FillChar(aPacketWithCRC, SizeOf(aPacketWithCRC), #0);
  aCountBytesToWrite:=0;

  PrepareModBusPacket(SendPacket,aPacketWithCRC,aCountBytesToWrite);
  StSendPacket:=MakeStringModBusPacket(aPacketWithCRC,aCountBytesToWrite);

  LogModBusExchange('-> '+StSendPacket);
end;

procedure TTLD_Auto.SetQueryEmulator;
begin
end;

procedure TTLD_Auto.ComPortFaultLog(aConnected: boolean);
begin
  if aConnected = FCOMPortFaultFlag then Exit; // предупреждение повторов

  if aConnected
    then LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPortConnection + ' '+COM + ' ' + rsReturned,'',cMsgNone,cMsgPriorityInf)
    else LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPortConnection + ' '+COM + ' ' + rsLost,'',cMsgNone,cMsgPriorityInf);

  FCOMPortFaultFlag:=aConnected;
end;

procedure TTLD_Auto.OnUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  aPacketWithCRC         : RBuff;
  i, aCountBytesToWrite  : integer;
  St,StSendPacket: string;
begin
// Если пришли спец. команды - разбираем
  // Стань сервером
  if length(AData)=length(cRemoteCaptureString) then
  begin
    St:='';
    for i:=0 to length(AData)-1 do
      St:=St+Chr(AData[i]);
    if St=cRemoteCaptureString then
    begin
      //IsTranslatorClient:=false;
      IsTranslatorServer:=true;
      Host:=ABinding.PeerIP;
      LogModBusExchange('    REMOTE SERVER STARTED');
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ','    REMOTE SERVER STARTED','',cMsgNone,cMsgPriorityInf);
      Exit;
    end;
  end;
  // Освободись - перестань быть сервером
  if length(AData)=length(cRemoteFreeString) then
  begin
    St:='';
    for i:=0 to length(AData)-1 do
      St:=St+Chr(AData[i]);
    if St=cRemoteFreeString then
    begin
      //IsTranslatorClient:=false;
      IsTranslatorServer:=false;
      Host:=ABinding.PeerIP;
      LogModBusExchange('    REMOTE SERVER STOPPED');
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ','    REMOTE SERVER STOPPED','',cMsgNone,cMsgPriorityInf);
      Exit;
    end;
  end;

// В сервер пришло от клиента - перенаправляем в COM-порт
// В клиент пришло от сервера - перенаправляем на обработку
  try
    aCountBytesToWrite:=Length(AData);
    for i:=0 to aCountBytesToWrite-1 do
      aPacketWithCRC[i]:=aData[i];

    StSendPacket:=MakeStringModBusPacket(aPacketWithCRC,aCountBytesToWrite);

    //LogModBusExchange('<<- '+StSendPacket);
    if Assigned(COMPortSyn) then
    begin
      if IsTranslatorServer then COMPortSyn.CP.SendBuffer(@aPacketWithCRC,aCountBytesToWrite);
      Host:=ABinding.PeerIP;
      if IsTranslatorClient then AsynchroOnReceiveModbus(aCountBytesToWrite,aPacketWithCRC);
    end;
  except
    on E: Exception do
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',E.Message,'',cMsgConnect,cMsgPriorityInf);
  end;

end;

procedure TTLD_Auto.AsynchroOnReceiveModbus(ReciveBytes: Cardinal; RecivBuff: RBuff);
var
  i: integer;
  CalculateCRC,ReceivedCRC  : word;
  RecivedModBusPacketBuff   : RBuff;
  ReceivedCRCBuff           : array [0..1] of byte;
  ReceivePacket             : String;
  RecivedTitleBuff          : PacketBuffTitle;    // массив байтов принятого заголовка
  RecivedBodyBuff           : PacketModBusBuff;   // массив байтов принятого блока данных
  //aPacketWithCRC      : RBuff;
  //aCountBytesToWrite  : integer;
  ABytes              : TIdBytes;
begin
  if ReciveBytes > 0 then
  begin
    if IsTranslatorServer and (Host<>'127.0.0.1') then // транслируем в обработку компорта другого компа
    try
      SetLength(ABytes,ReciveBytes);
      for i:=0 to ReciveBytes-1 do
        ABytes[i]:=RecivBuff[i];
      TransServer.SendBuffer(Host,cTranslatorPort,ABytes);
      ReceivePacket:=MakeStringModBusPacket(RecivBuff,ReciveBytes);
      LogModBusExchange('<<- '+ReceivePacket);
      Exit;
    except
    end;

    FillChar(RecivedTitleBuff, SizeOf(RecivedTitleBuff), #0);
    FillChar(RecivedBodyBuff, SizeOf(RecivedBodyBuff), #0);
    FillChar(ReceivedCRCBuff, SizeOf(ReceivedCRCBuff), #0);
    FillChar(RecivedModBusPacketBuff, SizeOf(RecivedModBusPacketBuff), #0);

    for i := 0 to ReciveBytes-3 do // пишем в буфер пакет без CRC
    begin
      RecivedModBusPacketBuff[i] := RecivBuff[i]; // пакет без CRC
    end;
// можно соптимизировать при случае
    CalculateCRC:=CalculateModBusCRC(RecivedModBusPacketBuff,ReciveBytes-2); //- вычитаем 2 т.к. байты CRC не должны войти
    ReceivedCRC:=ByteToWord(RecivBuff,ReciveBytes-1);

    if CalculateCRC=ReceivedCRC then // сравниваем посчитанное и принятое CRC заголовка данных
    begin
      for i := 0 to ReciveBytes-3 do // -3 т.к. не переписываем CRC в массив для разбора на верхнем уровне
        RecivedBodyBuff[i]:=RecivBuff[i];

      ReceivePacket:=MakeStringModBusPacket(RecivBuff,ReciveBytes);
      if IsTranslatorClient
        then LogModBusExchange('<<- '+ReceivePacket)
        else LogModBusExchange('<- '+ReceivePacket);

      TLDAnswer(RecivedBodyBuff,ReciveBytes-2);

    end
    else  // если CRC не совпадает
    begin
      LogModBusExchange('<- '+'CRC-error  (' + IntToStr(ReciveBytes)+': '+ MakeStringModBusPacket(RecivBuff,ReciveBytes) + ')');
      LogModBusExchange('-> '+rsRecall);
      ModbusReadWriteComand_03_06_10(FLastSendedPacket);
//      NNReadState;
    end;
  end;
end;

//var
//  PrevStateCommand: integer;          // предыдущая команда
//  PrevStateEngine : integer;          // предыдущее состояние двигателя
//  PrevStateStove  : integer;          // предыдущее состояние печки

procedure TTLD_Auto.TLDAnswer(Packet: PacketModBusBuff; Bytes: integer);
var
  i,j: integer;
  CalculateCRC,ReceivedCRC  : word;
  BaseAdr: word;
  buf: byte;
  St: AnsiString;
  SendBuf: array of word;
  DBuf: DWord;
  impMax: DWord;
  DelayTime: integer;
  CurTemp: real;

  procedure RunNext;
  begin
    if (LastTag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
  end;

begin
  AnswerTime:=Now;

  // Диагностический след: фиксируем факт разбора ответа и его длину для текущего состояния.
  // Сама ветка case ниже по-прежнему может не найти подходящего условия (Bytes=N) для конкретной
  // ветки и ничего не сделать - эта строка лога не меняет такое поведение, а лишь делает его видимым:
  // сопоставив время с уже пишущимся логом сырых пакетов (LogModBusExchange), легко заметить, что
  // именно пришло и почему не было обработано.
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ',Format(rsAnswerTrace,[CNTQuery,Bytes]),'',cMsgRead,cMsgPriorityInf);

  case CNTQuery of
// MotorsBoard
    cCNTMotorsSetPosition:
    begin
      if (Bytes=6) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        if OnMotorsSetPosition<>Nil then OnMotorsSetPosition(LastMotorSet);
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsReadProgress:
    begin
      if (Bytes=9) and (Packet[0]=01) and (Packet[1]=03) then
      begin
        Motors.Connected:=true; // признак связи
        //i := round((Packet[3]-1)/3); // извлекаем номер мотора из адреса
        Motors.ReadMotor[LastMotorSet].Status := Packet[4] + Packet[3]*256;
        Motors.ReadMotor[LastMotorSet].Message := Packet[6] + Packet[5]*256;
        Motors.ReadMotor[LastMotorSet].Progress := Packet[8];
        if (OnMotorsReadBase <>Nil) then OnMotorsReadBase;
        if (OnMotorsReadProgress <>Nil) then OnMotorsReadProgress(LastMotorSet);
        if LastMotorSet=1 then Panel.Output.Motors_D1_Progress := Motors.ReadMotor[LastMotorSet].Progress;

        case Motors.ReadMotor[LastMotorSet].Status of
          //if (Motors.ReadMotor[LastMotorSet].Status = $0001)  then
        $0001:
          begin
            if LastMotorSet=1 then Panel.Output.Motors_D1_Progress := Motors.ReadMotor[LastMotorSet].Progress;
            Panel.Output.Motors_Status[LastMotorSet] := Motors.ReadMotor[LastMotorSet].Status;
            CNTQuery:=cCNTMotorsReadProgress;
            NNMotorsReadProgress(LastTag,LastMotorSet);
            if (OnMotorsReadBase <>Nil) then OnMotorsReadBase;
          end;

          //if ((Motors.ReadMotor[LastMotorSet].Status = $0000) or (Motors.ReadMotor[LastMotorSet].Status = $0002)) then
        $0000,$0002:
          begin
            LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ',rsMotorCommandDone,'',cMsgNone,cMsgPriorityInf);

            RunNext;
          end;

          //if (Motors.ReadMotor[LastMotorSet].Status = $0003)  then
        $0003:
          begin
            Panel.Output.Motors_Status[LastMotorSet] := Motors.ReadMotor[LastMotorSet].Status;
            LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ',rsMotorCommandDoneWErr,'',cMsgNone,cMsgPriorityInf);
            if Motors.IgnoreAnswerError then
            begin
              if (OnSuccesExecute<>Nil) then OnSuccesExecute;
            end
              else
                begin
                  OnTLDError(True);
                end;
          end;
        end; // of case
      end;
    end;

    cCNTMotorsGetDeviceID:
    begin
      if (Bytes=5) and (Packet[0]=01) and (Packet[1]=03) then
      begin
        Motors.Connected:=true; // признак связи
        Motors.DeviceNumber:=Packet[3]*256+Packet[4];

        if Assigned(OnReceiveDeviceID) then OnReceiveDeviceID(Motors.DeviceNumber);

        RunNext; //if (LastTag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;

    cCNTMotors_ReadBase_CS:
    begin
      if (Bytes=49) and (Packet[0]=01) and (Packet[1]=03) then
      begin
        Motors.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  //  пишем в данные пакет без первых 3-х байт
          Motors.ByteArray[i-3] := Packet[i];

        // коррекция x86 хранения в памяти
        Motors.Protocol := Swap(Motors.Protocol);
        Motors.Common_Status := Swap(Motors.Common_Status);
        Motors.Power_Status := Swap(Motors.Power_Status);
        Motors.DigitalInput := Swap(Motors.DigitalInput);
        Motors.DigitalOutput := Swap(Motors.DigitalOutput);
        for i := 1 to 6 do
        begin
          Motors.ReadMotor[i].Status := Swap(Motors.ReadMotor[i].Status);
          Motors.ReadMotor[i].Message := Swap(Motors.ReadMotor[i].Message);
          Motors.ReadMotor[i].Progress := Swap(Motors.ReadMotor[i].Progress);
        end;

        with Motors do
        begin
          Panel.Output.Motors_CommonStatus := Common_Status;
          Panel.Output.Motors_InputLines := 0;
          if ReadMotor[1].Message and $2000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 1;  //0 D13       Motors_OP0
          if ReadMotor[1].Message and $4000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 2;  //1 D14       Motors_PS1
          if ReadMotor[1].Message and $8000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 4;  //2 D15       Motors_PS2
          if ReadMotor[2].Message and $4000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 8;  //3 D14       Motors_OP1
          if ReadMotor[2].Message and $8000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 16; //4 D15       Motors_PS3
          if ReadMotor[3].Message and $4000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 32; //5 D14       Motors_OP2
          if ReadMotor[3].Message and $8000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 64; //6 D15       Motors_PS4
          if ReadMotor[4].Message and $4000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 128;//7 D14       Motors_OP3
          if ReadMotor[5].Message and $4000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 256;//8 D14       Motors_OP4
          if ReadMotor[5].Message and $8000 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 512;//9 D15       Motors_OP5
          if Power_Status and $01 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 1024;   //10 D0 Powerline1
          if Power_Status and $02 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 2048;   //11 D1 Powerline2
          if DigitalInput and $01 <> 0 then Panel.Output.Motors_InputLines := Panel.Output.Motors_InputLines + 4096;   //12 D0 PS5

          for i := 1 to 5 do
            Panel.Output.Motors_Status[i] := Motors.ReadMotor[i].Status;
          Panel.Output.Motors_D1_Progress := Motors.ReadMotor[1].Progress;
        end;

        if (OnMotorsReadBase<>Nil) then OnMotorsReadBase;

        if (LastTag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
     end;

    cCNTMotorsReadParams1:
    begin
      if (Bytes=17) and (Packet[0]=01) and (Packet[1]=03) then
      begin
        Motors.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт со смещением по виду запроса
          Motors.ByteArray[80+i-3] := Packet[i];

        // коррекция x86 хранения в памяти
        for i := 1 to 6 do
        begin
          Motors.Motor_Command[i] := Swap(Motors.Motor_Command[i]);
        end;
        Motors.Power_Command := Swap(Motors.Power_Command);

        if (OnMotorsReadRWParams1<>Nil) then OnMotorsReadRWParams1;

        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;

    cCNTMotorsReadParams2:
    begin
      if (Bytes=165) and (Packet[0]=01) and (Packet[1]=03) then
      begin
        Motors.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт со смещением по виду запроса
          Motors.ByteArray[202+i-3] := Packet[i];

        // коррекция x86 хранения в памяти
        for i := 1 to 6 do
        begin
          Motors.WriteMotor[i].MaxSteps := Swap(Motors.WriteMotor[i].MaxSteps);
          Motors.WriteMotor[i].NumVars := Swap(Motors.WriteMotor[i].NumVars);
          //for j := 1 to min(10,Motors.WriteMotor[i].NumVars) do
          //  Motors.WriteMotor[i].Vars[j] := Swap(Motors.WriteMotor[i].Vars[j]);
          //for j := Motors.WriteMotor[i].NumVars+1 to 10 do
          //  Motors.WriteMotor[i].Vars[j] := 0;
          for j := 1 to 10 do
            Motors.WriteMotor[i].Vars[j] := Swap(Motors.WriteMotor[i].Vars[j]);
        end;
        Motors.DeviceNumber := Swap(Motors.DeviceNumber);
        Motors.Stat_NumMoves := Swap(Motors.Stat_NumMoves);
        Motors.Stat_NumMovesTo1 := Swap(Motors.Stat_NumMovesTo1);
        Motors.Stat_NumErrMoves := Swap(Motors.Stat_NumErrMoves);
        Motors.StatCorr_Max := Swap(Motors.StatCorr_Max);
        Motors.StatCorr_Min := Swap(Motors.StatCorr_Min);
        Motors.StatCorr_Avg := Swap(Motors.StatCorr_Avg);
        Motors.EEPROMCounter:= Swap(Motors.EEPROMCounter);

        if (OnMotorsReadRWParams2<>Nil) then OnMotorsReadRWParams2;

        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;

    cCNTMotorsStop:
    begin
      if (Bytes=6) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        //if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;

    cCNTMotorsInit:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsInit1_251_CS:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsInit1_252_CS:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsInit1_253_CS:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsInit2_253_CS:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsInit3_253_CS:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsInit4_253_CS:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNTMotorsInit5_253_CS:
    begin
      if (Bytes=06) and (Packet[0]=01) and (Packet[1]=06) then
      begin
        Motors.Connected:=true; // признак связи
        CNTQuery:=cCNTMotorsReadProgress;
        NNMotorsReadProgress(LastTag,LastMotorSet);
      end;
    end;

    cCNT_PLChange: // только для команд из Control
    begin
      if (Bytes=6) and (packet[0]=1) and (packet[1]=6) then
      begin
        Motors.Connected:=true; // признак связи
        NNMotors_ReadBase_CS('',cRunSingle);
      end;
    end;

    cCNTMotors_PL1On_CS:
    begin
      if (Bytes=6) and (packet[0]=1) and (packet[1]=6) then
      begin
        Motors.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTMotors_PL1Off_CS:
    begin
      if (Bytes=6) and (packet[0]=1) and (packet[1]=6) then
      begin
        Motors.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTMotors_PL2On_CS:
    begin
      if (Bytes=6) and (packet[0]=1) and (packet[1]=6) then
      begin
        Motors.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTMotors_PL2Off_CS:
    begin
      if (Bytes=6) and (packet[0]=1) and (packet[1]=6) then
      begin
        Motors.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTMotors_PL3On_CS:
    begin
      if (Bytes=6) and (packet[0]=1) and (packet[1]=6) then
      begin
        Motors.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTMotors_PL3Off_CS:
    begin
      if (Bytes=6) and (packet[0]=1) and (packet[1]=6) then
      begin
        Motors.Connected:=true; // признак связи
        RunNext;
      end;
    end;

//AirHeat
    cCNTAirHeat_ReadInput_CS:
    begin
      if (Bytes=25) and (Packet[0]=$20) and (Packet[1]=04) then // Новая плата
      begin
        AirHeat.Connected:=true; // признак связи
        //for i := 3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
        for i := 3 to Bytes-3 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3+2] := Packet[i]; // пропускаем давление

        AirHeat.Temperature[1] := Swap(AirHeat.Temperature[1]);
        AirHeat.Temperature[2] := Swap(AirHeat.Temperature[2]);
        AirHeat.Temperature[3] := Swap(AirHeat.Temperature[3]);
        AirHeat.Temperature[4] := Swap(AirHeat.Temperature[4]);

        AirHeat.Flow[1] := Swap(AirHeat.Flow[1]);
        AirHeat.Flow[2] := Swap(AirHeat.Flow[2]);
        AirHeat.Flow[3] := Swap(AirHeat.Flow[3]);
        AirHeat.Flow[4] := Swap(AirHeat.Flow[4]);

        Panel.Output.AirHeat_Temp1        := AirHeat.Temperature[2];
        Panel.Output.AirHeat_Temp2        := AirHeat.Temperature[3];
        Panel.Output.AirHeat_Flow1        := AirHeat.Flow[2];
        Panel.Output.AirHeat_Flow2        := AirHeat.Flow[3];

        for i := Bytes-2 to Bytes-1 do // Записываем код ошибки куда надо
          AirHeat.ByteArray[i-3+2*$13] := Packet[i]; // В ErrorCode

        if (OnReceiveTemp<>Nil) then OnReceiveTemp;
        if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

        RunNext;
      end;
    end;

    cCNTAirHeat_ReadHolding_CS:
    begin
      if (Bytes=19) and (Packet[0]=$20) and (Packet[1]=03) then // Новая плата
      begin
        AirHeat.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3+11*2] := Packet[i]; // Записываем во второй блок, начиная с температуры преднагрева

        AirHeat.PreHeatTemperature := Swap(AirHeat.PreHeatTemperature);
        AirHeat.PreHeatRate := Swap(AirHeat.PreHeatRate);
        AirHeat.PreHeatTime := Swap(AirHeat.PreHeatTime);
        AirHeat.HeatTemperature := Swap(AirHeat.HeatTemperature);
        AirHeat.HeatRate := Swap(AirHeat.HeatRate);
        AirHeat.HeatTime := Swap(AirHeat.HeatTime);
        AirHeat.Position := Swap(AirHeat.Position);
        AirHeat.HeatingCtrl := Swap(AirHeat.HeatingCtrl);

        if LastTag = cRunSingle then  // Признак выполнения из Control
          NNAirHeat_ReadInput_CS('',cRunSingle);

        if (OnReceiveTemp<>Nil) then OnReceiveTemp;

        if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

        RunNext;
      end;
    end;

    cCNTAirHeatReadAll_OLD:
    begin
      if (Bytes>0) and (Packet[0]=$20) then
      begin
        if (Bytes=35) and (Packet[0]=$20) and ((Packet[1]=03) or (Packet[1]=04)) then // Старая плата
        begin
          AirHeat.Connected:=true; // признак связи

          for i := 3 to 27+3-1 do // пишем в данные пакет без первых 3-х байт
            AirHeat.ByteArray[i-3] := Packet[i];
          AirHeat.ByteArray[27] := 0;
          for i := 27+3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
            AirHeat.ByteArray[i-2] := Packet[i];


          AirHeat.Temperature[1] := Swap(AirHeat.Temperature[1]);
          AirHeat.Temperature[2] := Swap(AirHeat.Temperature[2]);
          AirHeat.Temperature[3] := Swap(AirHeat.Temperature[3]);
          AirHeat.Temperature[4] := Swap(AirHeat.Temperature[4]);

          if AirHeat.HeatTemperature<AirHeat.PreHeatTemperature then
            AirHeat.HeatTemperature := AirHeat.HeatTemperature + 256; // КОРРЕКЦИЯ ОШИБКИ КИТАЙЦЕВ

          AirHeat.Flow[1] := Swap(AirHeat.Flow[1]);
          AirHeat.Flow[2] := Swap(AirHeat.Flow[2]);
          AirHeat.Flow[3] := Swap(AirHeat.Flow[3]);
          AirHeat.Flow[4] := Swap(AirHeat.Flow[4]);

          Panel.Output.AirHeat_Temp1        := AirHeat.Temperature[2];
          Panel.Output.AirHeat_Temp2        := AirHeat.Temperature[3];
          Panel.Output.AirHeat_Flow1        := AirHeat.Flow[2];
          Panel.Output.AirHeat_Flow2        := AirHeat.Flow[3];

          if (OnReceiveTemp<>Nil) then OnReceiveTemp;

          if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

          RunNext;
        end

      end;
    end;

    cCNTAirHeatWriteProfile_OLD:
    begin
      if (Bytes=21) and (Packet[0]=$20) and (Packet[1]=$10) then
      begin
        AirHeat.Connected:=true; // признак связи

        RunNext;
      end;
    end;

    cCNTAirHeat_WriteProfile_CS:
    begin
      //if (Bytes=21) and (Packet[0]=$20) and (Packet[1]=$10) then
      begin
        AirHeat.Connected:=true; // признак связи

        RunNext;
      end;
    end;

    cCNTAirHeatA1_OLD:
    begin
      if (Bytes=35) and (Packet[0]=$20) and (Packet[1]=$03) then
      begin
        // Old plate:
        AirHeat.Connected:=true; // признак связи
        for i := 3 to 27+3-1 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3] := Packet[i];
        for i := 27+3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3] := Packet[i];

        AirHeat.Temperature[1] := Swap(AirHeat.Temperature[1]);
        AirHeat.Temperature[2] := Swap(AirHeat.Temperature[2]);
        AirHeat.Temperature[3] := Swap(AirHeat.Temperature[3]);
        AirHeat.Temperature[4] := Swap(AirHeat.Temperature[4]);
        AirHeat.Flow[1] := Swap(AirHeat.Flow[1]);
        AirHeat.Flow[2] := Swap(AirHeat.Flow[2]);
        AirHeat.Flow[3] := Swap(AirHeat.Flow[3]);
        AirHeat.Flow[4] := Swap(AirHeat.Flow[4]);
        AirHeat.HeatTemperature := AirHeat.HeatTemperature + 256; // КОРРЕКЦИЯ ОШИБКИ КИТАЙЦЕВ

        Panel.Output.AirHeat_Temp1        := AirHeat.Temperature[2];
        Panel.Output.AirHeat_Temp2        := AirHeat.Temperature[3];
        Panel.Output.AirHeat_Flow1        := AirHeat.Flow[2];
        Panel.Output.AirHeat_Flow2        := AirHeat.Flow[3];

        if (OnReceiveTemp<>Nil) then OnReceiveTemp;

        if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

        RunNext;
      end;
    end;

    cCNTAirHeatA2_OLD:
    begin
      if (Bytes=06) and (Packet[0]=$20) and (Packet[1]=$06) then
      begin
        AirHeat.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTAirHeat_Start_CS:
    begin
      if (Bytes=06) and (Packet[0]=$20) and (Packet[1]=$10) then
      begin
        AirHeat.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTAirHeat_Stop_CS:
    begin
      if (Bytes=06) and (Packet[0]=$20) and (Packet[1]=$06) then
      begin
        AirHeat.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTAirHeatA4_OLD:
    begin
      if (Bytes=21) and (Packet[0]=$20) and (Packet[1]=$10) then
      begin
        AirHeat.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    cCNTAirHeatA5_inKTV_OLD:
    begin
      if (Bytes=35) and (Packet[0]=$20) and (Packet[1]=$03) then
      begin
        AirHeat.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3] := Packet[i];

        AirHeat.Temperature[1] := Swap(AirHeat.Temperature[1]);
        AirHeat.Temperature[2] := Swap(AirHeat.Temperature[2]);
        AirHeat.Temperature[3] := Swap(AirHeat.Temperature[3]);
        AirHeat.Temperature[4] := Swap(AirHeat.Temperature[4]);
        AirHeat.HeatTemperature := AirHeat.HeatTemperature + 256; // КОРРЕКЦИЯ ОШИБКИ КИТАЙЦЕВ
        //AirHeat.PreHeatTemperature := Swap(AirHeat.PreHeatTemperature);
        //AirHeat.PreHeatRate := Swap(AirHeat.PreHeatRate);
        //AirHeat.PreHeatTime := Swap(AirHeat.PreHeatTime);
        //AirHeat.HeatRate := Swap(AirHeat.HeatRate);
        //AirHeat.HeatTime := Swap(AirHeat.HeatTime);
        AirHeat.Flow[1] := Swap(AirHeat.Flow[1]);
        AirHeat.Flow[2] := Swap(AirHeat.Flow[2]);
        AirHeat.Flow[3] := Swap(AirHeat.Flow[3]);
        AirHeat.Flow[4] := Swap(AirHeat.Flow[4]);

        Panel.Output.AirHeat_Temp1        := AirHeat.Temperature[2];
        Panel.Output.AirHeat_Temp2        := AirHeat.Temperature[3];
        Panel.Output.AirHeat_Flow1        := AirHeat.Flow[2];
        Panel.Output.AirHeat_Flow2        := AirHeat.Flow[3];

        LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsAirHeatReadedTemp,[AirHeat.Temperature[2]/10,AirHeat.Temperature[3]/10]),'',cMsgRead,cMsgPriorityInf);

        if (AirHeat.Temperature[2] > 10*cMaxStartMeasureTemp) and  // температура больше cMaxStartMeasureTemp градусов
           (AirHeat.Temperature[3] > 10*cMaxStartMeasureTemp) and  // температура больше cMaxStartMeasureTemp градусов
           (LastTag<>cRunSingle) and
           (PMT.CurrentReaded<300) and // Процесс считывания ещё идёт
           ((AirHeat.Flow[2] <= cMinFlow) or (AirHeat.Flow[3] <= cMinFlow)) then // аварийная остановка из-за малой прокачки на температуре
        begin
          NNAccident(accLowFlow);
          Exit; // Прерываем цикл запросов
        end;

        //for i:=PMT.CurrentReaded to 299 do TempResult1[i]:=Round(AirHeat.Temperature[2]/10);
        //for i:=PMT.CurrentReaded to 299 do TempResult2[i]:=Round(AirHeat.Temperature[3]/10);
        //for i:=PMT.CurrentReadedPrev to PMT.CurrentReaded do TempResult[i]:=Round(AirHeat.Temperature[2]+AirHeat.Temperature[3]/20);
        PMT.CurrentTemp:=(AirHeat.Temperature[2] + AirHeat.Temperature[3]) div 2;
        for i:=PMT.CurrentReadedPrev to PMT.CurrentReaded-1 do
          TempResult[i]:= PMT.CurrentTempPrev + (PMT.CurrentTemp-PMT.CurrentTempPrev)*(i-PMT.CurrentReadedPrev) div (PMT.CurrentReaded-PMT.CurrentReadedPrev);

        if (OnReceiveTemp<>Nil) then OnReceiveTemp;

        if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

        if (OnReceiveResults<>Nil) and (PMT.CurrentReaded - PMT.CurrentReadedPrev>0) then // передача в MainForm считанного по очереди
        begin
          SetLength(SendBuf,PMT.CurrentReaded - PMT.CurrentReadedPrev);
          Panel.Output.D1_KTVControl:=0;
          Panel.Output.D2_KTVControl:=0;
          Panel.Output.D3_KTVControl:=0;
          Panel.Output.D4_KTVControl:=0;

          DetNumber:=0;
          if Algorithms.CurrentCarretePosition = carDet23 then DetNumber:=1; // 1 это детектор  2
          if not Panel.DontUse and ModbusClient.Connected then // отсылка КТВ1
          begin
            case DetNumber of
              0: begin BaseAdr:=1300; Panel.Output.D1_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D1_KTVControl:=3; end; // 1300+300*i
              1: begin BaseAdr:=1610; Panel.Output.D2_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D2_KTVControl:=3; end;
              2: begin BaseAdr:=1920; Panel.Output.D3_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D3_KTVControl:=3; end;
              3: begin BaseAdr:=2230; Panel.Output.D4_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D4_KTVControl:=3; end;
            end;
            for i:=0 to PMT.CurrentReaded-PMT.CurrentReadedPrev-1 do
            begin
              DBuf := PMT.Buffer_total[i+PMT.CurrentReadedPrev].Channel1;
              if DBuf>65534 then DBuf:=65535; // Можно ещё добавить какой-нибудь признак переполнения
              SendBuf[i] := DBuf;
            end;
            ModbusClient.WriteRegisters(BaseAdr + PMT.CurrentReadedPrev,SendBuf);
          end;
          if ChangeData.DetectorCount=2 then DetNumber:=DetNumber-1; // исключение детектора 0 для 2-хдетекторного дозиметра при отрисовке в текущем MainForm
          SetLength(ImpulseResult,PMT.CurrentReaded);
          // Заполняем данные по одному и вызываем обработчик для каждого

          impMax := 0;
          for i:=0 to PMT.CurrentReaded-1 do
          begin
            ImpulseResult[i] := PMT.Buffer_total[i].Channel1;
            if ImpulseResult[i]>impMax then impMax:=ImpulseResult[i];
          end;
          if impMax<>PMT.CurrentPulsesMax_Ch1 then
          begin
            PMT.CurrentPulsesMax_Ch1 := impMax;
            if not Panel.DontUse and ModbusClient.Connected then // отсылка в панель
              ModbusClient.WriteRegister(BaseAdr - 1,impMax);
          end;
          OnReceiveResults;

          DetNumber:=3; // детектор 4
          if Algorithms.CurrentCarretePosition = carDet23 then DetNumber:=2; // 2 это детектор  3
          if not Panel.DontUse and ModbusClient.Connected then // отсылка КТВ2
          begin
            case DetNumber of
              0: begin BaseAdr:=1300; Panel.Output.D1_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D1_KTVControl:=3; end; // 1300+300*i
              1: begin BaseAdr:=1610; Panel.Output.D2_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D2_KTVControl:=3; end;
              2: begin BaseAdr:=1920; Panel.Output.D3_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D3_KTVControl:=3; end;
              3: begin BaseAdr:=2230; Panel.Output.D4_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D4_KTVControl:=3; end;
            end;
            for i:=0 to PMT.CurrentReaded-PMT.CurrentReadedPrev-1 do
            begin
              DBuf := PMT.Buffer_total[i+PMT.CurrentReadedPrev].Channel2;
              if DBuf>65534 then DBuf:=65535; // Можно ещё добавить какой-нибудь признак переполнения
              SendBuf[i] := DBuf;
            end;
            ModbusClient.WriteRegisters(BaseAdr + PMT.CurrentReadedPrev,SendBuf);
          end;
          if ChangeData.DetectorCount=2 then DetNumber:=DetNumber-1; // исключение детектора 0 для 2-хдетекторного дозиметра при отрисовке в текущем MainForm

          impMax := 0;
          for i:=0 to PMT.CurrentReaded-1 do
          begin
            ImpulseResult[i] := PMT.Buffer_total[i].Channel2;
            if ImpulseResult[i]>impMax then impMax:=ImpulseResult[i];
          end;
          if impMax<>PMT.CurrentPulsesMax_Ch2 then
          begin
            PMT.CurrentPulsesMax_Ch2 := impMax;
            if not Panel.DontUse and ModbusClient.Connected then ModbusClient.WriteRegister(BaseAdr - 1,impMax);
          end;
          OnReceiveResults;

          if not Panel.DontUse and ModbusClient.Connected then // отсылка температурного профиля
          begin
            case Algorithms.CurrentCarretePosition of
              carDet23: BaseAdr:=3300;
              carDet14: BaseAdr:=3700;
            end;

            for i:=0 to PMT.CurrentReaded-PMT.CurrentReadedPrev-1 do
              SendBuf[i] := TempResult[i+PMT.CurrentReadedPrev];
            if not Panel.DontUse and ModbusClient.Connected then ModbusClient.WriteRegisters(BaseAdr + PMT.CurrentReadedPrev,SendBuf);
          end;
        end;
        if PMT.CurrentReaded < PMT.Measure_num_ch1
        then NNPMTReadKTV(LastTag)
        else NNPMT_ReadChannels_CS(LastParams,LastTag);
      end;
    end;

    cCNTAirHeat_ReadInKTV_CS:
    begin
      if (Bytes=25) and (Packet[0]=$20) and (Packet[1]=04) then // Новая плата
      begin
        AirHeat.Connected:=true; // признак связи
        //for i := 3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
        for i := 3 to Bytes-3 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3+2] := Packet[i]; // пропускаем давление

        AirHeat.Temperature[1] := Swap(AirHeat.Temperature[1]);
        AirHeat.Temperature[2] := Swap(AirHeat.Temperature[2]);
        AirHeat.Temperature[3] := Swap(AirHeat.Temperature[3]);
        AirHeat.Temperature[4] := Swap(AirHeat.Temperature[4]);

        AirHeat.Flow[1] := Swap(AirHeat.Flow[1]);
        AirHeat.Flow[2] := Swap(AirHeat.Flow[2]);
        AirHeat.Flow[3] := Swap(AirHeat.Flow[3]);
        AirHeat.Flow[4] := Swap(AirHeat.Flow[4]);

        Panel.Output.AirHeat_Temp1        := AirHeat.Temperature[2];
        Panel.Output.AirHeat_Temp2        := AirHeat.Temperature[3];
        Panel.Output.AirHeat_Flow1        := AirHeat.Flow[2];
        Panel.Output.AirHeat_Flow2        := AirHeat.Flow[3];

        for i := Bytes-2 to Bytes-1 do // Записываем код ошибки куда надо
          AirHeat.ByteArray[i-3+2*$13] := Packet[i]; // В ErrorCode

        LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsAirHeatReadedTemp,[AirHeat.Temperature[2]*1.0,AirHeat.Temperature[3]*1.0]),'',cMsgRead,cMsgPriorityInf);

        if (AirHeat.Temperature[2] > cMaxStartMeasureTemp) and  // температура больше cMaxStartMeasureTemp градусов
           (AirHeat.Temperature[3] > cMaxStartMeasureTemp) and  // температура больше cMaxStartMeasureTemp градусов
           (LastTag<>cRunSingle) and
           (PMT.CurrentReaded<300) and // Процесс считывания ещё идёт
           ((AirHeat.Flow[2] <= cMinFlow) or (AirHeat.Flow[3] <= cMinFlow)) then // аварийная остановка из-за малой прокачки на температуре
        begin
          NNAccident(accLowFlow);
          Exit; // Прерываем цикл запросов
        end;

        PMT.CurrentTemp:=(AirHeat.Temperature[2] + AirHeat.Temperature[3]) div 2;
        for i:=PMT.CurrentReadedPrev to PMT.CurrentReaded-1 do
          TempResult[i]:= PMT.CurrentTempPrev + (PMT.CurrentTemp-PMT.CurrentTempPrev)*(i-PMT.CurrentReadedPrev) div (PMT.CurrentReaded-PMT.CurrentReadedPrev);

        if (OnReceiveTemp<>Nil) then OnReceiveTemp;

        if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

        if (OnReceiveResults<>Nil) and (PMT.CurrentReaded - PMT.CurrentReadedPrev>0) then // передача в MainForm считанного по очереди
        begin
          SetLength(SendBuf,PMT.CurrentReaded - PMT.CurrentReadedPrev);
          Panel.Output.D1_KTVControl:=0;
          Panel.Output.D2_KTVControl:=0;
          Panel.Output.D3_KTVControl:=0;
          Panel.Output.D4_KTVControl:=0;

          DetNumber:=0;
          if Algorithms.CurrentCarretePosition = carDet23 then DetNumber:=1; // 1 это детектор  2
          if not Panel.DontUse and ModbusClient.Connected then // отсылка КТВ1
          begin
            case DetNumber of
              0: begin BaseAdr:=1300; Panel.Output.D1_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D1_KTVControl:=3; end; // 1300+300*i
              1: begin BaseAdr:=1610; Panel.Output.D2_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D2_KTVControl:=3; end;
              2: begin BaseAdr:=1920; Panel.Output.D3_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D3_KTVControl:=3; end;
              3: begin BaseAdr:=2230; Panel.Output.D4_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D4_KTVControl:=3; end;
            end;
            for i:=0 to PMT.CurrentReaded-PMT.CurrentReadedPrev-1 do
            begin
              DBuf := PMT.Buffer_total[i+PMT.CurrentReadedPrev].Channel1;
              if DBuf>65534 then DBuf:=65535; // Можно ещё добавить какой-нибудь признак переполнения
              SendBuf[i] := DBuf;
            end;
            ModbusClient.WriteRegisters(BaseAdr + PMT.CurrentReadedPrev,SendBuf);
          end;
          if ChangeData.DetectorCount=2 then DetNumber:=DetNumber-1; // исключение детектора 0 для 2-хдетекторного дозиметра при отрисовке в текущем MainForm
          SetLength(ImpulseResult,PMT.CurrentReaded);
          // Заполняем данные по одному и вызываем обработчик для каждого

          impMax := 0;
          for i:=0 to PMT.CurrentReaded-1 do
          begin
            ImpulseResult[i] := PMT.Buffer_total[i].Channel1;
            if ImpulseResult[i]>impMax then impMax:=ImpulseResult[i];
          end;
          if impMax<>PMT.CurrentPulsesMax_Ch1 then
          begin
            PMT.CurrentPulsesMax_Ch1 := impMax;
            if not Panel.DontUse and ModbusClient.Connected then // отсылка в панель
              ModbusClient.WriteRegister(BaseAdr - 1,impMax);
          end;
          OnReceiveResults;

          DetNumber:=3; // детектор 4
          if Algorithms.CurrentCarretePosition = carDet23 then DetNumber:=2; // 2 это детектор  3
          if not Panel.DontUse and ModbusClient.Connected then // отсылка КТВ2
          begin
            case DetNumber of
              0: begin BaseAdr:=1300; Panel.Output.D1_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D1_KTVControl:=3; end; // 1300+300*i
              1: begin BaseAdr:=1610; Panel.Output.D2_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D2_KTVControl:=3; end;
              2: begin BaseAdr:=1920; Panel.Output.D3_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D3_KTVControl:=3; end;
              3: begin BaseAdr:=2230; Panel.Output.D4_CurrentReaded:=PMT.CurrentReaded; Panel.Output.D4_KTVControl:=3; end;
            end;
            for i:=0 to PMT.CurrentReaded-PMT.CurrentReadedPrev-1 do
            begin
              DBuf := PMT.Buffer_total[i+PMT.CurrentReadedPrev].Channel2;
              if DBuf>65534 then DBuf:=65535; // Можно ещё добавить какой-нибудь признак переполнения
              SendBuf[i] := DBuf;
            end;
            ModbusClient.WriteRegisters(BaseAdr + PMT.CurrentReadedPrev,SendBuf);
          end;
          if ChangeData.DetectorCount=2 then DetNumber:=DetNumber-1; // исключение детектора 0 для 2-хдетекторного дозиметра при отрисовке в текущем MainForm

          impMax := 0;
          for i:=0 to PMT.CurrentReaded-1 do
          begin
            ImpulseResult[i] := PMT.Buffer_total[i].Channel2;
            if ImpulseResult[i]>impMax then impMax:=ImpulseResult[i];
          end;
          if impMax<>PMT.CurrentPulsesMax_Ch2 then
          begin
            PMT.CurrentPulsesMax_Ch2 := impMax;
            if not Panel.DontUse and ModbusClient.Connected then ModbusClient.WriteRegister(BaseAdr - 1,impMax);
          end;
          OnReceiveResults;

          if not Panel.DontUse and ModbusClient.Connected then // отсылка температурного профиля
          begin
            case Algorithms.CurrentCarretePosition of
              carDet23: BaseAdr:=3300;
              carDet14: BaseAdr:=3700;
            end;

            for i:=0 to PMT.CurrentReaded-PMT.CurrentReadedPrev-1 do
              SendBuf[i] := TempResult[i+PMT.CurrentReadedPrev];
            if not Panel.DontUse and ModbusClient.Connected then ModbusClient.WriteRegisters(BaseAdr + PMT.CurrentReadedPrev,SendBuf);
          end;
        end;
        if PMT.CurrentReaded < PMT.Measure_num_ch1
        then NNPMTReadKTV(LastTag)
        else NNPMT_ReadChannels_CS(LastParams,LastTag);
      end;
    end;

    cCNTAirHeatA6_OLD: // Ожидание остывания
    begin
      if (Bytes=35) and (Packet[0]=$20) and (Packet[1]=$03) then
      begin
        AirHeat.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3] := Packet[i];

        AirHeat.Temperature[1] := Swap(AirHeat.Temperature[1]);
        AirHeat.Temperature[2] := Swap(AirHeat.Temperature[2]);
        AirHeat.Temperature[3] := Swap(AirHeat.Temperature[3]);
        AirHeat.Temperature[4] := Swap(AirHeat.Temperature[4]);
        AirHeat.HeatTemperature := AirHeat.HeatTemperature + 256; // КОРРЕКЦИЯ ОШИБКИ КИТАЙЦЕВ
        AirHeat.Flow[1] := Swap(AirHeat.Flow[1]);
        AirHeat.Flow[2] := Swap(AirHeat.Flow[2]);
        AirHeat.Flow[3] := Swap(AirHeat.Flow[3]);
        AirHeat.Flow[4] := Swap(AirHeat.Flow[4]);

        Panel.Output.AirHeat_Temp1        := AirHeat.Temperature[2];
        Panel.Output.AirHeat_Temp2        := AirHeat.Temperature[3];
        Panel.Output.AirHeat_Flow1        := AirHeat.Flow[2];
        Panel.Output.AirHeat_Flow2        := AirHeat.Flow[3];

        LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsAirHeatA6,[AirHeat.Temperature[2]/10,AirHeat.Temperature[3]/10,cMaxStartMeasureTemp]),'',cMsgRead,cMsgPriorityInf);

        if (OnReceiveTemp<>Nil) then OnReceiveTemp;

        if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

        if (AirHeat.Temperature[2]>cMaxStartMeasureTemp*10) or (AirHeat.Temperature[3]>cMaxStartMeasureTemp*10) then
        begin
          Sleep(50);
          NNAirHeat_CoolingDown_CS(LastParams,LastTag); // продолжаем ожидание остывания
        end
          else
            RunNext;
      end;
    end;

    cCNTAirHeat_Cooling_CS: // Ожидание остывания
    begin
      if (Bytes=25) and (Packet[0]=$20) and (Packet[1]=04) then // Новая плата
      begin
        AirHeat.Connected:=true; // признак связи
        //for i := 3 to Bytes-1 do // пишем в данные пакет без первых 3-х байт
        for i := 3 to Bytes-3 do // пишем в данные пакет без первых 3-х байт
          AirHeat.ByteArray[i-3+2] := Packet[i]; // пропускаем давление

        AirHeat.Temperature[1] := Swap(AirHeat.Temperature[1]);
        AirHeat.Temperature[2] := Swap(AirHeat.Temperature[2]);
        AirHeat.Temperature[3] := Swap(AirHeat.Temperature[3]);
        AirHeat.Temperature[4] := Swap(AirHeat.Temperature[4]);

        AirHeat.Flow[1] := Swap(AirHeat.Flow[1]);
        AirHeat.Flow[2] := Swap(AirHeat.Flow[2]);
        AirHeat.Flow[3] := Swap(AirHeat.Flow[3]);
        AirHeat.Flow[4] := Swap(AirHeat.Flow[4]);

        Panel.Output.AirHeat_Temp1        := AirHeat.Temperature[2];
        Panel.Output.AirHeat_Temp2        := AirHeat.Temperature[3];
        Panel.Output.AirHeat_Flow1        := AirHeat.Flow[2];
        Panel.Output.AirHeat_Flow2        := AirHeat.Flow[3];

        for i := Bytes-2 to Bytes-1 do // Записываем код ошибки куда надо
          AirHeat.ByteArray[i-3+2*$13] := Packet[i]; // В ErrorCode

        LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsAirHeatReadedTemp,[AirHeat.Temperature[2]*1.0,AirHeat.Temperature[3]*1.0]),'',cMsgRead,cMsgPriorityInf);

        if (OnReceiveTemp<>Nil) then OnReceiveTemp;

        if (OnAirHeatReadAll<>Nil) then OnAirHeatReadAll;

        if (AirHeat.Temperature[2]>cMaxStartMeasureTemp*10) or (AirHeat.Temperature[3]>cMaxStartMeasureTemp*10) then
        begin
          Sleep(50);
          NNAirHeat_CoolingDown_CS(LastParams,LastTag); // продолжаем ожидание остывания
        end
          else
            RunNext;
      end;
    end;

    cCNTAirHeatA7_OLD:
    begin
      if (Bytes=21) and (Packet[0]=$20) and (Packet[1]=$10) then
      begin
        AirHeat.Connected:=true; // признак связи
        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;

{
// MonitorBoard
    cCNTMonitorReadAll:
    begin
      if (Bytes=15) and (Packet[0]=$40) and (Packet[1]=$03) then
      begin
        MonitorBoard.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
          MonitorBoard.ByteArray[i-3] := Packet[i];

        MonitorBoard.CurrentTemperature := Swap(MonitorBoard.CurrentTemperature);
        MonitorBoard.TargetTemperature := Swap(MonitorBoard.TargetTemperature);
        for i := 1 to 4 do
          MonitorBoard.ReferenceLight[i] := Swap(MonitorBoard.ReferenceLight[i]);

        Panel.Output.Monitor_Current_Temp := MonitorBoard.CurrentTemperature;
        Panel.Output.Monitor_Target_Temp := MonitorBoard.TargetTemperature;
        Panel.Output.Monitor_RLCIntencity1 := MonitorBoard.ReferenceLight[2];
        Panel.Output.Monitor_RLCIntencity2 := MonitorBoard.ReferenceLight[3];

        if (OnMonitorReadAll<>Nil) then OnMonitorReadAll;

        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;

    cCNTMonitorM1:
    begin
      if (Bytes=15) and (Packet[0]=$40) and (Packet[1]=$03) then
      begin
        MonitorBoard.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
          MonitorBoard.ByteArray[i-3] := Packet[i];

        MonitorBoard.CurrentTemperature := Swap(MonitorBoard.CurrentTemperature);
        MonitorBoard.TargetTemperature := Swap(MonitorBoard.TargetTemperature);
        for i := 1 to 4 do
          MonitorBoard.ReferenceLight[i] := Swap(MonitorBoard.ReferenceLight[i]);

        Panel.Output.Monitor_Current_Temp := MonitorBoard.CurrentTemperature;
        Panel.Output.Monitor_Target_Temp := MonitorBoard.TargetTemperature;
        Panel.Output.Monitor_RLCIntencity1 := MonitorBoard.ReferenceLight[2];
        Panel.Output.Monitor_RLCIntencity2 := MonitorBoard.ReferenceLight[3];

        if (OnMonitorReadAll<>Nil) then OnMonitorReadAll;

        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;
    cCNTMonitorM2:
    begin
      if (Bytes=6) and (Packet[0]=$40) and (Packet[1]=$10) then
      begin
        MonitorBoard.Connected:=true; // признак связи
        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;
    cCNTMonitorM3:
    begin
      if (Bytes=6) and (Packet[0]=$40) and (Packet[1]=$10) then
      begin
        MonitorBoard.Connected:=true; // признак связи
        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;
    cCNTMonitorM4:
    begin
      if (Bytes=6) and (Packet[0]=$40) and (Packet[1]=$06) then
      begin
        MonitorBoard.Connected:=true; // признак связи
        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;
}
{
    cCNTPMTBoardReadAll: // PMTBoard
    begin
      if (Bytes=55) and (Packet[0]=$50) and (Packet[1]=$03) then
      begin
        PMTBoard.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
        begin
          PMTBoard.ByteArray[i-3] := Packet[i];
        end;

        PMTBoard.MeasureTime := Swap(PMTBoard.MeasureTime);
        PMTBoard.DeviceAddress := Swap(PMTBoard.DeviceAddress);
        PMTBoard.UID[1] := ConvertToDWord(PMTBoard.ByteArray[39],PMTBoard.ByteArray[38],PMTBoard.ByteArray[37],PMTBoard.ByteArray[36]); // Swap(PMTBoard.UID[1]);
        PMTBoard.UID[2] := ConvertToDWord(PMTBoard.ByteArray[43],PMTBoard.ByteArray[42],PMTBoard.ByteArray[41],PMTBoard.ByteArray[40]); // Swap(PMTBoard.UID[2]);
        PMTBoard.CPS := Swap(PMTBoard.CPS);
        PMTBoard.HighVoltageInit[1] := Swap(PMTBoard.HighVoltageInit[1]);
        PMTBoard.HighVoltageInit[2] := Swap(PMTBoard.HighVoltageInit[2]);
        PMTBoard.RealTimeCount[1] := ConvertSingleToSingle(PMTBoard.RealTimeCount[1]);
        PMTBoard.RealTimeCount[2] := ConvertSingleToSingle(PMTBoard.RealTimeCount[2]);
        PMTBoard.PreheatCount[1] := ConvertSingleToSingle(PMTBoard.PreheatCount[1]);
        PMTBoard.PreheatCount[2] := ConvertSingleToSingle(PMTBoard.PreheatCount[2]);
        PMTBoard.MeasureCount[1] := ConvertSingleToSingle(PMTBoard.MeasureCount[1]);
        PMTBoard.MeasureCount[2] := ConvertSingleToSingle(PMTBoard.MeasureCount[2]);
        PMTBoard.VoltageAdjustment[1] := Swap(PMTBoard.VoltageAdjustment[1]);
        PMTBoard.VoltageAdjustment[2] := Swap(PMTBoard.VoltageAdjustment[2]);
        PMTBoard.CounterTrigerring := Swap(PMTBoard.CounterTrigerring);
        PMTBoard.PreHeatTime := Swap(PMTBoard.PreHeatTime);

        if (OnPMTBoardReadAll<>Nil) then OnPMTBoardReadAll;

        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;

    cCNTPMTBoardP1:
    begin //  то же что и cCNTPMTBoardReadAll, но для автоматов
      if (Bytes=55) and (Packet[0]=$50) and (Packet[1]=$03) then
      begin
        PMTBoard.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
        begin
          PMTBoard.ByteArray[i-3] := Packet[i];
        end;

        PMTBoard.MeasureTime := Swap(PMTBoard.MeasureTime);
        PMTBoard.DeviceAddress := Swap(PMTBoard.DeviceAddress);
        PMTBoard.UID[1] := ConvertToDWord(PMTBoard.ByteArray[39],PMTBoard.ByteArray[38],PMTBoard.ByteArray[37],PMTBoard.ByteArray[36]); // Swap(PMTBoard.UID[1]);
        PMTBoard.UID[2] := ConvertToDWord(PMTBoard.ByteArray[43],PMTBoard.ByteArray[42],PMTBoard.ByteArray[41],PMTBoard.ByteArray[40]); // Swap(PMTBoard.UID[2]);
        PMTBoard.CPS := Swap(PMTBoard.CPS);
        PMTBoard.HighVoltageInit[1] := Swap(PMTBoard.HighVoltageInit[1]);
        PMTBoard.HighVoltageInit[2] := Swap(PMTBoard.HighVoltageInit[2]);
        PMTBoard.RealTimeCount[1] := ConvertSingleToSingle(PMTBoard.RealTimeCount[1]);
        PMTBoard.RealTimeCount[2] := ConvertSingleToSingle(PMTBoard.RealTimeCount[2]);
        PMTBoard.PreheatCount[1] := ConvertSingleToSingle(PMTBoard.PreheatCount[1]);
        PMTBoard.PreheatCount[2] := ConvertSingleToSingle(PMTBoard.PreheatCount[2]);
        PMTBoard.MeasureCount[1] := ConvertSingleToSingle(PMTBoard.MeasureCount[1]);
        PMTBoard.MeasureCount[2] := ConvertSingleToSingle(PMTBoard.MeasureCount[2]);
        PMTBoard.VoltageAdjustment[1] := Swap(PMTBoard.VoltageAdjustment[1]);
        PMTBoard.VoltageAdjustment[2] := Swap(PMTBoard.VoltageAdjustment[2]);
        PMTBoard.CounterTrigerring := Swap(PMTBoard.CounterTrigerring);
        PMTBoard.PreHeatTime := Swap(PMTBoard.PreHeatTime);

        if (OnPMTBoardReadAll<>Nil) then OnPMTBoardReadAll;

        if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;
}

//  PMT
    cCNTPMT_ReadBase_SC:
    begin //  Чтение базы, по необходимости дочитываем КТВ (с учётом переменной CurrentReaded)
      if (Bytes=61) and (Packet[0]=$0A) and (Packet[1]=$03) then
      begin
        PMT.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
        begin
          PMT.ByteArray[i-3] := Packet[i];
        end;
        PMT.Measure_instant_ch1 := BEtoN(PMT.Measure_instant_ch1);
        PMT.Measure_instant_ch2 := BEtoN(PMT.Measure_instant_ch2);
        PMT.Measure_num_ch1 := Swap(PMT.Measure_num_ch1);
        PMT.Measure_num_ch2 := Swap(PMT.Measure_num_ch2);
        PMT.Measure_time := Swap(PMT.Measure_time);
        PMT.Restart := Swap(PMT.Restart);

        PMT.Temp_ch1 := ConvertSingleToSingle2(PMT.Temp_ch1);
        PMT.Temp_ch2 := ConvertSingleToSingle2(PMT.Temp_ch2);
        PMT.Temp_setpoint := ConvertSingleToSingle2(PMT.Temp_setpoint);

        PMT.Dark_current_val_ch1 := BEtoN(PMT.Dark_current_val_ch1);
        PMT.Dark_current_val_ch2 := BEtoN(PMT.Dark_current_val_ch2);
        PMT.Ref_src_val_ch1 := BEtoN(PMT.Ref_src_val_ch1);
        PMT.Ref_src_val_ch2 := BEtoN(PMT.Ref_src_val_ch2);

        PMT.Dark_ref_Time := Swap(PMT.Dark_ref_Time);


        Panel.Output.PMTNew_Instant1 := PMT.Measure_instant_ch1;
        Panel.Output.PMTNew_Instant2 := PMT.Measure_instant_ch2;
        Panel.Output.PMTNew_MeasureTime := PMT.Measure_time;

        if PMT.CurrentReaded > PMT.Measure_num_ch1 then PMT.CurrentReaded:=0; // на всякий случай

        if (OnPMTNewReadBase<>Nil) then OnPMTNewReadBase;

        if (LastTag=cRunSingle) and (PMT.Measure_num_ch1<>0) then
        begin
          if (PMT.CurrentReaded < PMT.Measure_num_ch1)
          then NNPMTReadKTV(LastTag)
          else
            begin
              if PMT.Measure_num_ch1<300
              then NNAirHeat_ReadTempInKTV_CS(LastTag) // ПРОДОЛЖАЕМ ЧТЕНИЕ
            end;
        end
          else
            RunNext;
      end;
    end;

    cCNTPMT_ReadChans_SC: // Читаем число каналов в PMT и если оно не 300 - вычитываем КТВ
    begin //  Чтение базы, по необходимости дочитываем КТВ (с учётом переменной CurrentReaded)
      if (Bytes=07) and (Packet[0]=$0A) and (Packet[1]=$03) then
      begin
        PMT.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
        begin
          PMT.ByteArray[i-3+8] := Packet[i];
        end;

        PMT.Measure_num_ch1 := Swap(PMT.Measure_num_ch1);
        PMT.Measure_num_ch2 := Swap(PMT.Measure_num_ch2);

        if (OnPMTNewReadBase<>Nil) then OnPMTNewReadBase;

        if LastTag = cRunSingle then
        begin
          if PMT.CurrentReaded < PMT.Measure_num_ch1
          then NNPMTReadKTV(LastTag)
          else
            begin
              if (PMT.Measure_num_ch1<300) and (PMT.Measure_num_ch1<>0) // не закончилось, но стартовало
              then NNPMT_ReadChannels_CS(LastParams,LastTag); // ПРОДОЛЖАЕМ ЧТЕНИЕ
            end;
        end;

        if LastTag = cRunCommand then
        begin
          if PMT.CurrentReaded < PMT.Measure_num_ch1
          then NNAirHeat_ReadTempInKTV_CS(LastTag)//NNPMTReadKTV
          else
            begin
              if (PMT.Measure_num_ch1<300) and (PMT.IsMeasuring<>0) // не закончилось, но стартовало
              //then NNPMT_ReadChannels_CS // ПРОДОЛЖАЕМ ЧТЕНИЕ
              then NNAirHeat_ReadTempInKTV_CS(LastTag) // ПРОДОЛЖАЕМ ЧТЕНИЕ
              else
                RunNext;
            end;
        end;
      end;
    end;

{
    cCNTPMTNewPing:
    begin //  Чтение базы, по необходимости дочитываем КТВ (с учётом переменной CurrentReaded)
      if (Bytes=61) and (Packet[0]=$0A) and (Packet[1]=$03) then
      begin
        PMT.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
        begin
          PMT.ByteArray[i-3] := Packet[i];
        end;

        PMT.Measure_instant_ch1 := BEtoN(PMT.Measure_instant_ch1);
        PMT.Measure_instant_ch2 := BEtoN(PMT.Measure_instant_ch2);
        PMT.Measure_num_ch1 := Swap(PMT.Measure_num_ch1);
        PMT.Measure_num_ch2 := Swap(PMT.Measure_num_ch2);
        PMT.Measure_time := Swap(PMT.Measure_time);
        PMT.Restart := Swap(PMT.Restart); //?
        PMT.Temp_ch1 := ConvertSingleToSingle2(PMT.Temp_ch1);
        PMT.Temp_ch2 := ConvertSingleToSingle2(PMT.Temp_ch2);
        PMT.Temp_setpoint := ConvertSingleToSingle2(PMT.Temp_setpoint);

        PMT.Dark_current_val_ch1 := BEtoN(PMT.Dark_current_val_ch1);
        PMT.Dark_current_val_ch2 := BEtoN(PMT.Dark_current_val_ch2);
        PMT.Ref_src_val_ch1 := BEtoN(PMT.Ref_src_val_ch1);
        PMT.Ref_src_val_ch2 := BEtoN(PMT.Ref_src_val_ch2);
        PMT.Dark_ref_Time := Swap(PMT.Dark_ref_Time);

        Panel.Output.PMTNew_Instant1 := PMT.Measure_instant_ch1;
        Panel.Output.PMTNew_Instant2 := PMT.Measure_instant_ch2;
        Panel.Output.PMTNew_MeasureTime := PMT.Measure_time;

        if PMT.CurrentReaded > PMT.Measure_num_ch1 then PMT.CurrentReaded:=0; // на всякий случай

        if (OnPMTNewReadBase<>Nil) then OnPMTNewReadBase;

        if (LastTag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;

        //if PMT.CurrentReaded < PMT.Measure_num_ch1
        //then NNPMTReadKTV
        //else
        //  begin
        //    if PMT.Measure_num_ch1<300
        //    then NNAirHeat_ReadTempInKTV_CS // ПРОДОЛЖАЕМ ЧТЕНИЕ
        //  end;
      end;
    end;
}
    cCNTPMT_SetTime_CS,
    cCNTPMT_Start_CS:
    begin
      if (Bytes=06) and (Packet[0]=$0A) and (Packet[1]=$06) then
      begin
        PMT.Connected:=true; // признак связи
        if (CNTQuery=cCNTPMT_SetTime_CS) and (LastTag=cRunCommand) then // запуск измерения
        begin // запуск с попыткой синхронизации температурной кривой.
          CurTemp:=(AirHeat.Temperature[2]+AirHeat.Temperature[3])/2; //- переделать с учётом AirHeat разных версий

          if AirHeat.OldVersion
            then DelayTime := Round(1000*CurTemp/10/40)
            else DelayTime := Round(1000*CurTemp/30);

          LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewSleep,[DelayTime]),'',cMsgRead,cMsgPriorityInf);

          //sleep(DelayTime); // примерно 1000 на холодной { #todo -oЧернышев : Похоже надо делать задержку в обратную сторону }

          NNAirHeat_Start_CS(LastParams,LastTag)
        end
          else
            RunNext;
      end;
    end;

    cCNTPMT_WaitDone_CS:
    begin //  Чтение базы и признака завершения операции
      if (Bytes=61) and (Packet[0]=$0A) and (Packet[1]=$03) then
      begin
        PMT.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
        begin
          PMT.ByteArray[i-3] := Packet[i];
        end;
        PMT.Measure_instant_ch1 := BEtoN(PMT.Measure_instant_ch1);
        PMT.Measure_instant_ch2 := BEtoN(PMT.Measure_instant_ch2);
        PMT.Measure_num_ch1 := Swap(PMT.Measure_num_ch1);
        PMT.Measure_num_ch2 := Swap(PMT.Measure_num_ch2);
        PMT.Measure_time := Swap(PMT.Measure_time);
        PMT.Restart := Swap(PMT.Restart);

        PMT.Temp_ch1 := ConvertSingleToSingle2(PMT.Temp_ch1);
        PMT.Temp_ch2 := ConvertSingleToSingle2(PMT.Temp_ch2);
        PMT.Temp_setpoint := ConvertSingleToSingle2(PMT.Temp_setpoint);

        PMT.Dark_current_val_ch1 := BEtoN(PMT.Dark_current_val_ch1);
        PMT.Dark_current_val_ch2 := BEtoN(PMT.Dark_current_val_ch2);
        PMT.Ref_src_val_ch1 := BEtoN(PMT.Ref_src_val_ch1);
        PMT.Ref_src_val_ch2 := BEtoN(PMT.Ref_src_val_ch2);

        PMT.Dark_ref_Time := Swap(PMT.Dark_ref_Time);

        Panel.Output.PMTNew_Instant1 := PMT.Measure_instant_ch1;
        Panel.Output.PMTNew_Instant2 := PMT.Measure_instant_ch2;
        Panel.Output.PMTNew_MeasureTime := PMT.Measure_time;


        if (OnPMTNewReadBase<>Nil) then OnPMTNewReadBase;

        if PMT.IsMeasuring<>0
          then NNPMT_ReadProgress_CS(LastTag)
          else RunNext;
      end;
    end;

    cCNTPMTReadKTV:
    begin
      if (Bytes>=3) and (Packet[0]=10) and (Packet[1]=3) then
      begin
        PMT.Connected:=true; // признак связи

        for i := 0 to ((Bytes-3) div 8) -1 do  // переворачиваем
        begin
          PMT.Buffer_total[PMT.CurrentReaded + i].Channel1 := Packet[i*8+3] + Packet[i*8+3+1]*256 + Packet[i*8+3+2]*256*256 + Packet[i*8+3+3]*256*256*256;
          PMT.Buffer_total[PMT.CurrentReaded + i].Channel2 := Packet[i*8+3+4] + Packet[i*8+3+4+1]*256 + Packet[i*8+3+4+2]*256*256 + Packet[i*8+3+4+3]*256*256*256;
        end;

        PMT.CurrentReadedPrev := PMT.CurrentReaded; // запоминаем для выкладывания термопрофиля
        PMT.CurrentTempPrev := PMT.CurrentTemp;
        PMT.CurrentReaded := PMT.CurrentReaded + (Bytes-3) div 8;

        LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewReatKTV,[PMT.CurrentReaded,PMT.Measure_num_ch1]),'',cMsgRead,cMsgPriorityInf);

        if (OnPMTNewReadKTV<>Nil) then OnPMTNewReadKTV;

        NNAirHeat_ReadTempInKTV_CS(LastTag);
      end;
    end;

    cCNTPMTChange: // Изменения из Control
    begin
      PMT.Connected:=true; // признак связи
      NNPMT_ReadBase_CS('',cRunSingle); // перечитываем
    end;

    cCNTPMT_DarkCurStart_CS:
    begin
      if (Bytes=06) and (Packet[0]=$0A) and (Packet[1]=$06) then
      begin
        PMT.Connected:=true; // признак связи
        NNPMT_ReadProgress_CS(LastTag); // Ожидаем выполнения, вычитывая результат и флаг окончания
      end;
    end;

    cCNTPMT_SrcCurStart_CS:
    begin
      if (Bytes=06) and (Packet[0]=$0A) and (Packet[1]=$06) then
      begin
        PMT.Connected:=true; // признак связи
        NNPMT_ReadProgress_CS(LastTag); // Ожидаем выполнения, вычитывая результат и флаг окончания
      end;
    end;

    cCNTPMT_GetDevNumber:
    begin
      if (Bytes=07) and (Packet[0]=$0A) and (Packet[1]=$03) then
      begin
        PMT.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
          PMT.ByteArray[i-3+$968] := Packet[i];

        if (OnPMTNewGetDevNumber<>Nil) then OnPMTNewGetDevNumber;
      end;
    end;

    cCNTPMT_SetPeltierTemp_CS:
    begin
      if (Bytes=06) and (Packet[0]=$0A) and (Packet[1]=$10) then
      begin
        PMT.Connected:=true; // признак связи
        RunNext;
      end;
    end;

    {
    cCNTScanBoardStartRead:
    begin
      if (Bytes=06) and (Packet[0]=$60) and (Packet[1]=$06) then
      begin
        Scaner.Connected:=true; // признак связи
        Sleep(100);
        CNTQuery:=cCNTScanBoardReadBase;
        NNScanBoardReadBase;
        //if (OnScanBoardStartRead<>Nil) then OnScanBoardStartRead;
      end;
    end;

    cCNTScanBoardReadBase:
    begin
      if (Bytes=09) and (Packet[0]=$60) and (Packet[1]=$03) then
      begin
        Scaner.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
          Scaner.ByteArray[i-3+1] := Packet[i];

        if (Scaner.BarCodeScanStatus=1) or (Scaner.BarCodeLength<>0) then
        begin
          Sleep(20);
          CNTQuery:=cCNTScanBoardReadBarCode;
          NNScanBoardReadBarCode;
        end
          else
            RunNext;

        if (OnScanBoardReadBase<>Nil) then OnScanBoardReadBase;

      end;
    end;

    cCNTScanBoardReadBarCode:
    begin
      if (Bytes>3) and (Packet[0]=$60) and (Packet[1]=$03) then
      begin
        Scaner.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
          Scaner.BarCode[i-3] := Packet[i];

        with Scaner do
        begin
          for i:=0 to BarCodeLength div 2 +1 do
          begin // меняем байты местами
            buf := BarCode[2*i];
            BarCode[2*i] := BarCode[2*i+1];
            BarCode[2*i+1] := buf;
          end;

          BarCodeString:=''; // сначала только цифры
          St:=''; // для не цифр
          for i:=0 to BarCodeLength-1 do
          begin
            if (BarCode[i]>=48) and (BarCode[i]<=57) then // цифры
            begin
              if (BarCodeString<>'') or (BarCode[i]<>48) then // отсекаем ведущие нули
                BarCodeString := BarCodeString + AnsiChar(BarCode[i])
            end
              else // буквы
                if (BarCode[i]>32) // не пробел
                then St := St + AnsiChar(BarCode[i]);
          end;
        end;

        BarCodeString := BarCodeString + St;

        if length(BarCodeString)<=14 then
        begin
          for i:=1 to length(BarCodeString) do
            Panel.Output.DosimeterName[i] := ord(BarCodeString[i]);
          for i:=length(BarCodeString)+1 to 14 do
            Panel.Output.DosimeterName[i] := 0;
        end;

        if (OnScanBoardReadBarCode<>Nil) then OnScanBoardReadBarCode;

        //if (OnSuccesExecute<>Nil) then OnSuccesExecute;
      end;
    end;
}
// Scaner
    cCNTScan_ReadBase_CS:  //ReadBase Auto
    begin
      if (Bytes=09) and (Packet[0]=$60) and (Packet[1]=$03) then
      begin
        Scaner.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
          Scaner.ByteArray[i-3+1] := Packet[i];

        if (OnScanBoardReadBase<>Nil) then OnScanBoardReadBase;

        if (Scaner.BarCodeScanStatus=1) or (Scaner.BarCodeLength<>0) then
        begin
          Sleep(20);
          CNTQuery:=cCNTScan_ReadBarCode_CS;
          NNScan_ReadBarCode_CS(LastParams,LastTag);
        end
          else
        begin
          Scaner.BarCodeScanStatus:=0;
          Scaner.BarCodeLength:=0;
          LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ',rsScanFailed,'',cMsgRead,cMsgPriorityInf);
          RunNext;
        end;
      end;
    end;

    cCNTScan_Start_CS:  // StartRead Auto
    begin
      if (Bytes=06) and (Packet[0]=$60) and (Packet[1]=$06) then
      begin
        Scaner.Connected:=true; // признак связи
        Sleep(100);
        CNTQuery:=cCNTScan_ReadBase_CS;
        //if (OnScanBoardStartRead<>Nil) then OnScanBoardStartRead;
        NNScan_ReadBase_CS(LastParams,LastTag);
      end;
    end;

    cCNTScan_ReadBarCode_CS: // Scan BarCode
    begin
      if (Bytes>3) and (Packet[0]=$60) and (Packet[1]=$03) then
      begin
        Scaner.Connected:=true; // признак связи
        for i := 3 to Bytes-1 do  // пишем в данные пакет без первых 3-х байт
          Scaner.BarCode[i-3] := Packet[i];

        with Scaner do
        begin
          for i:=0 to BarCodeLength div 2 +1 do
          begin // меняем байты местами
            buf := BarCode[2*i];
            BarCode[2*i] := BarCode[2*i+1];
            BarCode[2*i+1] := buf;
          end;

          BarCodeString:=''; // сначала только цифры
          St:=''; // для не цифр
          for i:=0 to BarCodeLength-1 do
          begin
            if (BarCode[i]>=48) and (BarCode[i]<=57) then // цифры
            begin
              if (BarCodeString<>'') or (BarCode[i]<>48) then // отсекаем ведущие нули
                BarCodeString := BarCodeString + AnsiChar(BarCode[i])
            end
              else // буквы
                if (BarCode[i]>32) // не пробел
                then St := St + AnsiChar(BarCode[i]);
          end;
        end;

        BarCodeString := BarCodeString + St;

        if length(BarCodeString)<=14 then
        begin
          for i:=1 to length(BarCodeString) do
            Panel.Output.DosimeterName[i] := ord(BarCodeString[i]);
          for i:=length(BarCodeString)+1 to 14 do
            Panel.Output.DosimeterName[i] := 0;
        end;

        if (OnScanBoardReadBarCode<>Nil) then OnScanBoardReadBarCode;

        RunNext;
      end;
    end;
  end;

  //LastParams:=''; // Обнуляем параметры вызываемых процедур после обработки приёма
  //LastTag:=0;

  //ReceivePacketActive:=False;
end;

procedure TTLD_Auto.NNStopMeasuring;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsStopMeasurement,'',cMsgRead,cMsgPriorityInf);
  StartMeasuringFlag:=False;
  CNTQuery:=cCNTStopMeas;

  ModbusReadWriteComand_03_06_10(cStopMeasuring);
end;

procedure TTLD_Auto.NNAccident(anAccident: TAccident);
begin
  if anAccident=accLowFlow then
  begin
    LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAccLowFlow,'',cMsgRead,cMsgPriorityInf);
    //sleep(100); // исключаем наложение ответа
    NNAirHeat_Stop_CS('',0);
    if Assigned(OnCMDAccident) then OnCMDAccident(anAccident,rsAccLowFlow);
  end;
end;

procedure TTLD_Auto.NNMotorsSetPosition(Tag,aMotorID,aPosition: Int64);
begin
  SaveCallParams('', Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsSetPosition,[aMotorID,aPosition]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsSetPosition;

  if (aMotorID=1) then
  if (aPosition=3) then Algorithms.CurrentCarretePosition:=carDet14
  else
    if (aPosition=2) then Algorithms.CurrentCarretePosition:=carDet23;
    //else  Algorithms.CurrentCarretePosition:=carUnknown;

  if aMotorID=1 then Panel.Output.Motors_D1_Position := aPosition;

  LastMotorSet := aMotorID;

  ModbusReadWriteComand_03_06_10(Format(cMotorsSetPoint,[39 + aMotorID,aPosition])); //  1 <= aMotorID <= 6, 1 <= aPosition <= 8
end;

procedure TTLD_Auto.NNMotorsReadProgress(Tag,aMotorID: Int64);
begin
  SaveCallParams('', Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ',Format(rsMotorsReadProgress,[aMotorID]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsReadProgress;

  ModbusReadWriteComand_03_06_10(Format(cMotorsReadProgress,[3*aMotorID-1])); //  1 <= aMotorID <= 6, 1 <= aPosition <= 8
end;

procedure TTLD_Auto.NNMotors_GetDeviceID_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsReadDeviceNumber,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsGetDeviceID;

  ModbusReadWriteComand_03_06_10(cMotorsGetDeviceID); //  1 <= aMotorID <= 6, 1 <= aPosition <= 8
end;

procedure TTLD_Auto.NNMotorsStop(aMotorID: integer);
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsStop,[aMotorID]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsStop;

  ModbusReadWriteComand_03_06_10(Format(cMotorsStop,[39 + aMotorID])); //  1 <= aMotorID <= 6, 1 <= aPosition <= 8
end;

procedure TTLD_Auto.NNMotorsInit(aMotorID: integer);
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsInit,[aMotorID]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsInit;
  LastMotorSet := aMotorID;

  ModbusReadWriteComand_03_06_10(Format(cMotorsInit,[39 + aMotorID])); //  1 <= aMotorID <= 6, 1 <= aPosition <= 8
end;

procedure TTLD_Auto.NNMotors_Init1_251_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsInit1_251,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsInit1_251_CS;
  LastMotorSet := 1;

  ModbusReadWriteComand_03_06_10(cMotorsInit1_251);
end;

procedure TTLD_Auto.NNMotors_Init1_252_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsInit1_252,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsInit1_252_CS;
  LastMotorSet := 1;

  ModbusReadWriteComand_03_06_10(cMotorsInit1_252);
end;

procedure TTLD_Auto.NNMotors_Init1_253_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsInit,[1]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsInit1_253_CS;
  LastMotorSet := 1;

  ModbusReadWriteComand_03_06_10(cMotorsInit1_253);
end;

procedure TTLD_Auto.NNMotors_Init2_253_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsInit,[2]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsInit2_253_CS;
  LastMotorSet := 2;

  ModbusReadWriteComand_03_06_10(cMotorsInit2_253);
end;

procedure TTLD_Auto.NNMotors_Init3_253_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsInit,[3]),'',cMsgRead,cMsgPriorityInf);
  LastMotorSet := 3;
  CNTQuery:=cCNTMotorsInit3_253_CS;

  ModbusReadWriteComand_03_06_10(cMotorsInit3_253);
end;

procedure TTLD_Auto.NNMotors_Init4_253_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsInit,[4]),'',cMsgRead,cMsgPriorityInf);
  LastMotorSet := 4;
  CNTQuery:=cCNTMotorsInit4_253_CS;

  ModbusReadWriteComand_03_06_10(cMotorsInit4_253);
end;

procedure TTLD_Auto.NNMotors_Init5_253_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsInit,[5]),'',cMsgRead,cMsgPriorityInf);
  LastMotorSet := 5;
  CNTQuery:=cCNTMotorsInit5_253_CS;

  ModbusReadWriteComand_03_06_10(cMotorsInit5_253);
end;

//procedure TTLD_Auto.NNMotorsReadBase;
//begin
//  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsReadBase,'',cMsgRead,cMsgPriorityInf);
//  CNTQuery:=cCNTMotors_ReadBase_CS;
//
//  ModbusReadWriteComand_03_06_10(cMotors_ReadBase);
//end;

procedure TTLD_Auto.NNMotors_ReadBase_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsReadBase,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotors_ReadBase_CS;

  ModbusReadWriteComand_03_06_10(cMotors_ReadBase);
end;

var
  PeriodicControlPositionCount: integer = 0;
procedure TTLD_Auto.NNMotors_PosMonitoring_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  PeriodicControlPositionCount := (PeriodicControlPositionCount + 1) mod 20;
  if PeriodicControlPositionCount=0
    then NNMotors_Go1To1_CS(Params,Tag) //  - Позиционирование шагового двигателя каждые сколько-то заходов NNMotorsSetPosition(1,1);
    else
      if Tag=cRunCommand then
        if Assigned(OnSuccesExecute) then OnSuccesExecute;
end;

procedure TTLD_Auto.NNMotors_Go1To1_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,1,1); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go1To2_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,1,2); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go1To3_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,1,3); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go3To2_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,3,2); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go4To1_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,4,1); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go4To2_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,4,2); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go5To1_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,5,1); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go5To2_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,5,2); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotorsWriteParams4One(aMotorID: integer);
begin
  CNTQuery:=cCNTCommon;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMotorsWriteParams4One,[aMotorID]),'',cMsgRead,cMsgPriorityInf);
  LastMotorSet := aMotorID;

  ModbusReadWriteComand_03_06_10(Format(cMotorsWriteParams4One,[90 + aMotorID*12, Motors.WriteMotor[aMotorID].NumVars,
          Motors.WriteMotor[aMotorID].Vars[1], Motors.WriteMotor[aMotorID].Vars[2], Motors.WriteMotor[aMotorID].Vars[3],
          Motors.WriteMotor[aMotorID].Vars[4], Motors.WriteMotor[aMotorID].Vars[5], Motors.WriteMotor[aMotorID].Vars[6],
          Motors.WriteMotor[aMotorID].Vars[7], Motors.WriteMotor[aMotorID].Vars[8], Motors.WriteMotor[aMotorID].Vars[9],
          Motors.WriteMotor[aMotorID].Vars[10]]));
end;

procedure TTLD_Auto.NNMotorsWriteStatParams;
begin
  CNTQuery:=cCNTCommon;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsWriteStatParams,'',cMsgRead,cMsgPriorityInf);
  with Motors do
    ModbusReadWriteComand_03_06_10(Format(cMotorsWriteStatParams,[DeviceNumber,Stat_NumMoves,Stat_NumMovesTo1,Stat_NumErrMoves,StatCorr_Max,StatCorr_Min,StatCorr_Avg]));
end;

procedure TTLD_Auto.NNMotorsWriteEEPROM;
begin
  CNTQuery:=cCNTCommon;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsWriteEEPROM,'',cMsgRead,cMsgPriorityInf);

  ModbusReadWriteComand_03_06_10(cMotorsWriteEEPROM);
end;

procedure TTLD_Auto.NNMotors_Go1To5_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,1,5); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go1To6_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,1,6); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go2To1_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,2,1); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go2To2_CS(Params: String; Tag: Int64);
begin
  NNMotorsSetPosition(Tag,2,2); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go1To4_CS(Params: String; Tag: Int64);
begin
  Panel.Output.ProcessStatus := Panel.Output.ProcessStatus.SetBit(procstateDosimeterInMove); // Предполагаем что дозиметр будет на каретке
  NNMotorsSetPosition(Tag,1,4); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotors_Go3To1_CS(Params: String; Tag: Int64);
begin
  Panel.Output.ProcessStatus := Panel.Output.ProcessStatus.ClearBit(procstateScanInDB);// and $FFFE; // Поднимание Б скорее всего свзязано с перекладыванием дозиметра - сбрасываем его
  NNMotorsSetPosition(Tag,3,1); //  - Позиционирование шагового двигателя
end;

procedure TTLD_Auto.NNMotorsReadRWParams1;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsReadRWParams1,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsReadParams1;

  ModbusReadWriteComand_03_06_10(cMotorsReadRWParams1);
end;

procedure TTLD_Auto.NNMotorsReadRWParams2;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsReadRWParams2,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMotorsReadParams2;

  ModbusReadWriteComand_03_06_10(cMotorsReadRWParams2);
end;
//
//procedure TTLD_Auto.NNMotorsPowerLine1On;
//begin
//  CNTQuery:=cCNT_PLChange;
//  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine1On,'',cMsgRead,cMsgPriorityInf);
//
//  ModbusReadWriteComand_03_06_10(cMotorsPowerLine1On);
//end;
//
//procedure TTLD_Auto.NNMotorsPowerLine1Off;
//begin
//  CNTQuery:=cCNT_PLChange;
//  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine1Off,'',cMsgRead,cMsgPriorityInf);
//
//  ModbusReadWriteComand_03_06_10(cMotorsPowerLine1Off);
//end;
//
//procedure TTLD_Auto.NNMotorsPowerLine2On;
//begin
//  CNTQuery:=cCNT_PLChange;
//  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine2On,'',cMsgRead,cMsgPriorityInf);
//
//  ModbusReadWriteComand_03_06_10(cMotorsPowerLine2On);
//end;
//
//procedure TTLD_Auto.NNMotorsPowerLine2Off;
//begin
//  CNTQuery:=cCNT_PLChange;
//  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine2Off,'',cMsgRead,cMsgPriorityInf);
//
//  ModbusReadWriteComand_03_06_10(cMotorsPowerLine2Off);
//end;

procedure TTLD_Auto.NNMotors_PL3On_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  CNTQuery:=cCNTMotors_PL3On_CS;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine3On,'',cMsgRead,cMsgPriorityInf);
  ModbusReadWriteComand_03_06_10(cMotorsPowerLine3On);
end;

procedure TTLD_Auto.NNMotors_PL3Off_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  CNTQuery:=cCNTMotors_PL3Off_CS;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine3Off,'',cMsgRead,cMsgPriorityInf);
  ModbusReadWriteComand_03_06_10(cMotorsPowerLine3Off);
end;

procedure TTLD_Auto.NNMotors_PL1On_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  CNTQuery:=cCNTMotors_PL1On_CS;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine1On,'',cMsgRead,cMsgPriorityInf);

  ModbusReadWriteComand_03_06_10(cMotorsPowerLine1On);
end;

procedure TTLD_Auto.NNMotors_PL1Off_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  CNTQuery:=cCNTMotors_PL1Off_CS;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine1Off,'',cMsgRead,cMsgPriorityInf);

  ModbusReadWriteComand_03_06_10(cMotorsPowerLine1Off);
end;

procedure TTLD_Auto.NNMotors_PL2On_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  CNTQuery:=cCNTMotors_PL2On_CS;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine2On,'',cMsgRead,cMsgPriorityInf);

  ChangeData.WaitTime:=15;

  ModbusReadWriteComand_03_06_10(cMotorsPowerLine2On);
end;

procedure TTLD_Auto.NNMotors_PL2Off_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  CNTQuery:=cCNTMotors_PL2Off_CS;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsPowerLine2Off,'',cMsgRead,cMsgPriorityInf);

  ModbusReadWriteComand_03_06_10(cMotorsPowerLine2Off);
end;

procedure TTLD_Auto.NNMotorsWriteDigitalOutput(aOutputs: word);
begin
  CNTQuery:=cCNTCommon;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsWriteDigitalOutput,'',cMsgRead,cMsgPriorityInf);

  ModbusReadWriteComand_03_06_10(Format(cMotorsWriteDigitalOutput,[aOutputs])); //  1 <= aMotorID <= 6, 1 <= aPosition <= 8
end;


procedure TTLD_Auto.NNAirHeatReadAll;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatReadAll,'',cMsgRead,cMsgPriorityInf);

  if AirHeat.OldVersion then
  begin
    CNTQuery:=cCNTAirHeatReadAll_OLD;
    ModbusReadWriteComand_03_06_10(cAirHeatReadAll_Old)
  end
    else
  begin
    NNAirHeat_ReadHolding_CS('',cRunSingle); // Чтение параметров AirHeat New - Holding Registers
    //CNTQuery:=cCNTAirHeatReadHolding;
    //ModbusReadWriteComand_03_06_10(cAirHeat_ReadHolding);
  end;
end;

procedure TTLD_Auto.NNAirHeat_ReadHolding_CS(Params: String; Tag: Int64); // Чтение параметров AirHeatBoard New - Holding Registers
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatReadHolding,'',cMsgRead,cMsgPriorityInf);

  CNTQuery:=cCNTAirHeat_ReadHolding_CS;
  ModbusReadWriteComand_03_06_10(cAirHeat_ReadHolding);
end;

procedure TTLD_Auto.NNAirHeat_ReadInput_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatReadInput,'',cMsgRead,cMsgPriorityInf);

  CNTQuery:=cCNTAirHeat_ReadInput_CS;
  ModbusReadWriteComand_03_06_10(cAirHeat_ReadInput);
end;

procedure TTLD_Auto.NNAirHeatWriteProfile(Tag: Int64; aMode,aPreHeatTemp, aPreHeatRate, aPreHeatTime,
  aHeatTemp, aHeatRate, aHeatTime: string);
var
  Mode,PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime: word;
begin
  SaveCallParams('', Tag);

  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsAirHeatWriteProfile,['Mode='+aMode+' PreHeatTemp='+aPreHeatTemp+' PreHeatRate='+aPreHeatRate+' HeatTime='+aPreHeatTime+' HeatTemp='+aHeatTemp+' HeatRate='+aHeatRate+' HeatTime='+aHeatTime]),'',cMsgRead,cMsgPriorityInf);
  Mode :=  StrToInt(aMode);
  PreHeatTemp :=  StrToInt(aPreHeatTemp);
  PreHeatRate :=  StrToInt(aPreHeatRate);
  PreHeatTime :=  StrToInt(aPreHeatTime);
  HeatTemp    :=  StrToInt(aHeatTemp);
  HeatRate    :=  StrToInt(aHeatRate);
  HeatTime    :=  StrToInt(aHeatTime);

  if AirHeat.OldVersion then
  begin
    CNTQuery := cCNTAirHeatWriteProfile_OLD;
    PreHeatTemp :=  Round(StrToFloat(aPreHeatTemp)*10);
    HeatTemp    :=  Round(StrToFloat(aHeatTemp)*10);
    ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile_Old,[Mode,PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом
  end
    else
  begin
    CNTQuery := cCNTAirHeat_WriteProfile_CS;
    ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile,[PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом (Mode - не используем)
  end;

  Panel.Output.AirHeat_PreHeat_Temp := PreHeatTemp;
  Panel.Output.AirHeat_PreHeat_Time := PreHeatTime;
  Panel.Output.AirHeat_PreHeat_Rate := PreHeatRate;
  Panel.Output.AirHeat_Heat_Temp    := HeatTemp;
  Panel.Output.AirHeat_Heat_Time    := HeatTime;
  Panel.Output.AirHeat_Heat_Rate    := HeatRate;
end;

procedure TTLD_Auto.NNAirHeatWriteStatus(aHeatStatus: word);
begin
  CNTQuery:=cCNTCommon;
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsAirHeatWriteStatus,[aHeatStatus]),'',cMsgRead,cMsgPriorityInf);

  ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteStatus_Old,[aHeatStatus]));
end;

// Команды для автоматов
procedure TTLD_Auto.NNAirHeat_WriteProfMeas_CS(Params: String; Tag: Int64); // Записать профиль измерения
var
  Mode,PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime: integer;
  St: string;
  Buf : integer;
  CurrentTemp: integer;
begin
  SaveCallParams(Params, Tag);
  with ChangeData.Detectors[Algorithms.CurrentCarretePosition] do
  begin
    if AirHeat.OldVersion then
    begin
      CNTQuery:=cCNTAirHeatWriteProfile_OLD;
      Mode :=  $6100;
      PreHeatTemp :=  Round(temp_preheat*10);
      PreHeatRate :=  25; //$19
      PreHeatTime :=  Round(time_preheat);
      HeatTemp    :=  Round(temp_meas*10);
      //HeatRate    :=  25; //$19
      HeatRate    :=  Round(temp_rate);
      HeatTime    :=  Round(time_meas);

      // Коррекция времени в китайских нагревателях с учётом того что время разогрева они не учитывают.
      Buf := (PreHeatTemp-250) div 250; // Ориентировочное время в секундах на прогрев до полки (с учетом T*10)
      if PreHeatTime>=Buf  then PreHeatTime := PreHeatTime - Buf else PreHeatTime := 0; // Коррекция китайского несовершенства (сдвижка полки влево)
      //Buf := (HeatTemp-PreHeatTemp) div (10*HeatRate); // Ориентировочное время на прогрев до полки
      //if HeatTime>=Buf  then HeatTime := HeatTime - Buf else HeatTime := 0; // Коррекция китайского несовершенства (сдвижка полки влево на 4 секунды)

      ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile_Old,[Mode,PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом
    end
      else
    begin
      CNTQuery:=cCNTAirHeat_WriteProfile_CS;

      PreHeatTemp :=  Round(temp_preheat);
      PreHeatRate :=  30;
      PreHeatTime :=  Round(time_preheat);
      HeatTemp    :=  Round(temp_meas);
      HeatRate    :=  Round(temp_rate);
      HeatTime    :=  Round(time_meas);

      // Коррекция времени в китайских нагревателях с учётом того что время разогрева они не учитывают.
      if (temp_rate>=1) and (HeatTemp>=PreHeatTemp) then // and (temp_preheat>=cMaxStartMeasureTemp)
      begin

        //CurrentTemp:=min(AirHeat.Temperature[2],AirHeat.Temperature[3]);
        //if (CurrentTemp=0) then CurrentTemp:=20; // оценка на случай непрочитанности температуры перед этим.
        //Buf := Round((temp_preheat-CurrentTemp/10) / PreHeatRate); // Ориентировочное время в секундах на прогрев до полки (с учетом T)
        Buf := Round((temp_preheat-25) / PreHeatRate); // Ориентировочное время в секундах на прогрев до полки (с 0)
        PreHeatTime := PreHeatTime - Buf;
        if PreHeatTime<0 then
        begin
          HeatTime := HeatTime + PreHeatTime;
          PreHeatTime := 0; // Коррекция несовпадения моделей (старого DozaTLD и DozaTLD_Auto в сторону певого (сдвижка полки влево))
        end;
        Buf := Round((HeatTemp-PreHeatTemp) / temp_rate); // Ориентировочное время на прогрев от полки до температуры измерения
        HeatTime := HeatTime - Buf;
        if HeatTime<0
          then HeatTime := 0
          else HeatTime:=HeatTime+5; // Запас в 5 секунды чтоб не вылетело по недостатку воздушного потока
      end;

      //if (HeatRate>0) and (PreHeatTemp>=25) and (HeatTemp>=PreHeatTemp) then
      //begin
      //  Buf := (PreHeatTemp-25) div 25; // Ориентировочное время в секундах на прогрев до полки (с учетом T)
      //  if PreHeatTime>=Buf  then PreHeatTime := PreHeatTime - Buf else PreHeatTime := 0; // Коррекция китайского несовершенства (сдвижка полки влево на 4 секунды)
      //  Buf := (HeatTemp-PreHeatTemp) div HeatRate; // Ориентировочное время на прогрев до полки
      //  if HeatTime>=Buf  then HeatTime := HeatTime - Buf else HeatTime := 0; // Коррекция китайского несовершенства (сдвижка полки влево)
      //end;

      //ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile,[PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом (Mode - не используем)
      ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile,[PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом (Mode - не используем)
    end;
  end;

  Panel.Output.AirHeat_PreHeat_Temp := PreHeatTemp;
  Panel.Output.AirHeat_PreHeat_Time := PreHeatTime;
  Panel.Output.AirHeat_PreHeat_Rate := PreHeatRate;
  Panel.Output.AirHeat_Heat_Temp    := HeatTemp;
  Panel.Output.AirHeat_Heat_Time    := HeatTime;
  Panel.Output.AirHeat_Heat_Rate    := HeatRate;

  St:= IntTostr(PreHeatTemp)+':'+IntTostr(PreHeatTime)+'-'+IntTostr(HeatTemp)+':'+IntTostr(HeatTime);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsAirHeatWriteProfile,[St]),'',cMsgRead,cMsgPriorityInf);

  //ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile_Old,[Mode,PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом

end;

procedure TTLD_Auto.NNAirHeat_ReadTemp_CS(Params: String; Tag: Int64); //  Команда чтения
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatA1,'',cMsgRead,cMsgPriorityInf);

  if AirHeat.OldVersion then
  begin
    CNTQuery:=cCNTAirHeatReadAll_OLD;
    ModbusReadWriteComand_03_06_10(cAirHeatReadAll_Old)
  end
    else
  begin
    NNAirHeat_ReadInput_CS('',Tag); // Чтение температур и потоков
  end;

  //CNTQuery:=cCNTAirHeatA1_OLD;
  //
  //ModbusReadWriteComand_03_06_10(cAirHeatA1_Old);
end;

procedure TTLD_Auto.NNAirHeat_Start_CS(Params: String; Tag: Int64); //  Старт измерения
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatA2,'',cMsgRead,cMsgPriorityInf);

  if AirHeat.OldVersion then
  begin
    CNTQuery:=cCNTAirHeatA2_OLD;
    ModbusReadWriteComand_03_06_10(cAirHeat_Start_Old)
  end
  else
  begin
    CNTQuery:=cCNTAirHeat_Start_CS;
    ModbusReadWriteComand_03_06_10(Format(cAirHeat_Start,[6]));  //?
  end;
end;

procedure TTLD_Auto.NNAirHeat_Stop_CS(Params: String; Tag: Int64); //  Принудительная остановка измерения
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatA3,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTAirHeat_Stop_CS;

  if AirHeat.OldVersion
    then ModbusReadWriteComand_03_06_10(cAirHeat_Stop_Old)
    else ModbusReadWriteComand_03_06_10(cAirHeat_Stop);
end;

procedure TTLD_Auto.NNAirHeat_WriteProfBurn_CS(Params: String; Tag: Int64); // Отжиг
var
  Mode,PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime: integer;
  St: string;
  Buf : integer;
  CurrentTemp: integer;
begin
  SaveCallParams(Params, Tag);
  with ChangeData.Detectors[Algorithms.CurrentCarretePosition] do
  begin
    if AirHeat.OldVersion then
    begin
      CNTQuery:=cCNTAirHeatA4_OLD;
      Mode :=  $6100;
      PreHeatTemp :=  Round(temp_burn*10);
      PreHeatRate :=  25;
      PreHeatTime :=  0;
      HeatTemp    :=  Round(temp_burn*10);
      HeatRate    :=  25;
      HeatTime    :=  Round(time_burn);

{
      // Коррекция времени в китайских нагревателях с учётом того что время разогрева они не учитывают.
      Buf := (PreHeatTemp-250) div 250; // Ориентировочное время в секундах на прогрев до полки (с учетом T*10)
      if PreHeatTime>=Buf  then PreHeatTime := PreHeatTime - Buf else PreHeatTime := 0; // Коррекция китайского несовершенства (сдвижка полки влево)
      //Buf := (HeatTemp-PreHeatTemp) div (10*HeatRate); // Ориентировочное время на прогрев до полки
      //if HeatTime>=Buf  then HeatTime := HeatTime - Buf else HeatTime := 0; // Коррекция китайского несовершенства (сдвижка полки влево на 4 секунды)
}
      ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile_Old,[Mode,PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом
    end
      else
    begin
      CNTQuery:=cCNTAirHeat_WriteProfile_CS;

      PreHeatTemp :=  Round(temp_burn);
      PreHeatRate :=  30;
      PreHeatTime :=  0;
      HeatTemp    :=  Round(temp_burn);
      HeatRate    :=  30;
      HeatTime    :=  Round(time_meas);

      ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile,[PreHeatTemp, PreHeatRate, PreHeatTime,HeatTemp, HeatRate, HeatTime])); //  Параметры нагрева скопом (Mode - не используем)
    end;
    Panel.Output.AirHeat_BurnHeat_Temp    := HeatTemp;
    Panel.Output.AirHeat_BurnHeat_Time    := HeatTime;
    Panel.Output.AirHeat_BurnHeat_Rate    := HeatRate;

    St:= IntTostr(PreHeatTemp)+':'+IntTostr(PreHeatTime)+'-'+IntTostr(HeatTemp)+':'+IntTostr(HeatTime);
    LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatWriteBurnProfile + ' '+St,'',cMsgRead,cMsgPriorityInf);
  end;
end;

procedure TTLD_Auto.NNAirHeat_ReadTempInKTV_CS(Tag: Int64); //  Команда чтения температуры в процессе измерения
begin
  SaveCallParams('', Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsAirHeatA5_inKTV,'',cMsgRead,cMsgPriorityInf);
  //CNTQuery:=cCNTAirHeatA5_inKTV_OLD;

  if AirHeat.OldVersion then
  begin
    CNTQuery:=cCNTAirHeatA5_inKTV_Old;
    ModbusReadWriteComand_03_06_10(cAirHeatA1_Old)
  end
  else
  begin
    CNTQuery:=cCNTAirHeat_ReadInKTV_CS;
    ModbusReadWriteComand_03_06_10(cAirHeat_ReadInput);
  end;
end;

procedure TTLD_Auto.NNAirHeat_CoolingDown_CS(Params: String; Tag: Int64); // Ожидание остывания
begin
  SaveCallParams(Params, Tag);

  if AirHeat.OldVersion then
  begin
    //CNTQuery:=cCNTAirHeatA5_inKTV_Old;
    CNTQuery:=cCNTAirHeatA6_OLD;
    ModbusReadWriteComand_03_06_10(cAirHeatA1_Old)
  end
  else
  begin
    //CNTQuery:=cCNTAirHeat_ReadInKTV_CS;
    CNTQuery:=cCNTAirHeat_Cooling_CS;
    ModbusReadWriteComand_03_06_10(cAirHeat_ReadInput);
  end;
end;

procedure TTLD_Auto.NNAirHeat_CheckAir_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  NNAirHeatWriteProfile(Tag,IntToStr($0061), '90',       '25',          '0',           '90',    '25',       '60'); //  Параметры нагрева скопом
//  CNTQuery:=cCNTAirHeatA7_OLD;
  //LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',format(rsAirHeatWriteProfile,[' 25-10 - Test Flow']),'',cMsgRead,cMsgPriorityInf);
//  ModbusReadWriteComand_03_06_10(Format(cAirHeatWriteProfile_Old,[$6100, 25*10,       25,          0,           25*10,    25,       60])); //  Параметры нагрева скопом
end;

{
procedure TTLD_Auto.NNMonitorReadAll;
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMonitorReadAll,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMonitorReadAll;

  ModbusReadWriteComand_03_06_10(cMonitorReadAll);
end;

procedure TTLD_Auto.NNMonitorWriteAll(aTargetTemperature, aRLCIntencity1, aRLCIntencity2, aRLCIntencity3, aRLCIntencity4: string);
var
  TargetTemperature, RLCIntencity1, RLCIntencity2, RLCIntencity3, RLCIntencity4: word;
begin
  CNTQuery:=cCNTCommon;
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMonitorWriteAll,'',cMsgRead,cMsgPriorityInf);
  TargetTemperature  :=  Round(StrToFloat(aTargetTemperature)*10);
  RLCIntencity1      :=  Round(StrToFloat(aRLCIntencity1)*10);
  RLCIntencity2      :=  Round(StrToFloat(aRLCIntencity2)*10);
  RLCIntencity3      :=  Round(StrToFloat(aRLCIntencity3)*10);
  RLCIntencity4      :=  Round(StrToFloat(aRLCIntencity4)*10);

  ModbusReadWriteComand_03_06_10(Format(cMonitorWriteAll,[TargetTemperature, RLCIntencity1, RLCIntencity2, RLCIntencity3, RLCIntencity4])); //  Параметры монитора скопом
end;

procedure TTLD_Auto.NNMonitorInit;
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMonitorInit,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMonitorInit;

  ModbusReadWriteComand_03_06_10(cMonitorInit);
end;

procedure TTLD_Auto.NNMonitorM1(Params: String; Tag: Int64);
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMonitorM1,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMonitorM1;

  ModbusReadWriteComand_03_06_10(cMonitorM1);
end;

procedure TTLD_Auto.NNMonitorM2(Params: String; Tag: Int64);
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMonitorM2,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMonitorM2;

  ModbusReadWriteComand_03_06_10(cMonitorM2);
end;

procedure TTLD_Auto.NNMonitorM3(Params: String; Tag: Int64);
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMonitorM3,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMonitorM3;

  ModbusReadWriteComand_03_06_10(cMonitorM3);
end;

procedure TTLD_Auto.NNMonitorM4(Params: String; Tag: Int64); // Инициализация Пельтье
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsMonitorM4,[MonitorBoard.TargetTempFromIni*10]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTMonitorM4;

  ModbusReadWriteComand_03_06_10(Format(cMonitorM4,[MonitorBoard.TargetTempFromIni*10]));
end;

procedure TTLD_Auto.NNPMTBoardReadAll;
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTReadAll,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMTBoardReadAll;

  ModbusReadWriteComand_03_06_10(cPMTBoardReadAll);
end;

procedure TTLD_Auto.NNPMTBoardWriteAll(aCounterTriggering, aHVFineAdjustment1,
  aHVFineAdjustment2, aPreheatTime, aMeasureTime: string);
var
  CounterTriggering, HVFineAdjustment1,
  HVFineAdjustment2, PreheatTime, MeasureTime: word;
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTWriteAll,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMTBoardWriteAll;
  CounterTriggering   :=  StrToInt(aCounterTriggering);
  HVFineAdjustment1   :=  StrToInt(aHVFineAdjustment1);
  HVFineAdjustment2   :=  StrToInt(aHVFineAdjustment2);
  PreheatTime         :=  StrToInt(aPreheatTime);
  MeasureTime         :=  StrToInt(aMeasureTime);

  ModbusReadWriteComand_03_06_10(Format(cPMTBoardWriteAll,[CounterTriggering, HVFineAdjustment1, HVFineAdjustment2, PreheatTime, MeasureTime]));
end;

procedure TTLD_Auto.NNPMTBoardP1(Params: String; Tag: Int64);
begin
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTP1,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMTBoardP1;

  ModbusReadWriteComand_03_06_10(cPMTBoardP1);
end;
}

procedure TTLD_Auto.NNPMT_ReadBase_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTReadBase,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_ReadBase_SC;

  ModbusReadWriteComand_03_06_10(cPMT_ReadBase);
end;

procedure TTLD_Auto.NNPMTReadKTV(Tag: Int64);
var
  BaseAdr, Len: word;
begin
  SaveCallParams('', Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTReadKTV,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMTReadKTV;

 // Дочитка нового куска
  BaseAdr := PMT.CurrentReaded*4 + $04B8;
  Len := 4*min(25,PMT.Measure_num_ch1-PMT.CurrentReaded);
  ModbusReadWriteComand_03_06_10(Format(cPMT_ReadKTV,[BaseAdr, Len])); // Предполагается что чтение базовых регистров перед этим произведено
  { #todo -oЧернышев : Хорошо бы сделать в этом месте контроль на Len<>0 }
end;

procedure TTLD_Auto.NNPMT_ReadChannels_CS(Params: String; Tag: Int64); // Читаем число каналов в PMT и если оно не 300 - вычитываем КТВ
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTReadNumChan,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_ReadChans_SC;

  ModbusReadWriteComand_03_06_10(cPMT_ReadNumChan);
end;

procedure TTLD_Auto.NNPMT_SetTime_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTSetTime,[Round(ChangeData.Detectors[Algorithms.CurrentCarretePosition].sumTimes)]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_SetTime_CS;

  ModbusReadWriteComand_03_06_10(Format(cPMT_SetTime,[Round(ChangeData.Detectors[Algorithms.CurrentCarretePosition].sumTimes)]));

  PMT.CurrentReaded := 0;
  PMT.CurrentReadedPrev := 0;
  PMT.CurrentTemp := (AirHeat.Temperature[2]+AirHeat.Temperature[3]) div 2;
  PMT.CurrentTempPrev := PMT.CurrentTemp;
end;

procedure TTLD_Auto.NNPMTStart(Tag: Int64);
begin
  SaveCallParams('', Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTStart,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_Start_CS;

  ModbusReadWriteComand_03_06_10(cPMT_Start);

  PMT.CurrentReaded := 0;
  PMT.CurrentReadedPrev := 0;
  PMT.CurrentTemp := (AirHeat.Temperature[2]+AirHeat.Temperature[3]) div 2;
  PMT.CurrentTempPrev := PMT.CurrentTemp;
end;

procedure TTLD_Auto.NNPMT_ReadProgress_CS(Tag: Int64);
begin
  SaveCallParams('', Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTWaitDone,'',cMsgRead,cMsgPriorityInf);

  CNTQuery:=cCNTPMT_WaitDone_CS;

  ModbusReadWriteComand_03_06_10(cPMT_ReadBase);
end;

procedure TTLD_Auto.NNPMTSwitch(SubdeviceNum: integer; State: byte); // Включить - выключить LED или элемент Пельтье 1-Led1, 2-Led2, 3- Пельтье
begin
  CNTQuery:=cCNTPMTChange;
  case SubdeviceNum of
    1:
    begin
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewSwitch1,[State]),'',cMsgRead,cMsgPriorityInf);
      ModbusReadWriteComand_03_06_10(Format(cPMT_Switch,[$0A,State]));
    end;
    2:
    begin
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewSwitch2,[State]),'',cMsgRead,cMsgPriorityInf);
      ModbusReadWriteComand_03_06_10(Format(cPMT_Switch,[$0B,State]));
    end;
    3:
    begin
      LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewSwitch3,[State]),'',cMsgRead,cMsgPriorityInf);
      ModbusReadWriteComand_03_06_10(Format(cPMT_Switch,[$1A,State]));
    end;
  end;
end;

procedure TTLD_Auto.NNPMT_DarkCurStart_CS(Params: String; Tag: Int64);// Запуск измерения темнового тока
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTNewDarkCurStart,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_DarkCurStart_CS;

  ModbusReadWriteComand_03_06_10(cPMT_DarkCurStart);
end;

procedure TTLD_Auto.NNPMT_SrcCurStart_CS(Params: String; Tag: Int64); // Запуск измерения тока от контрольного источника
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTNewSrcCurStart,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_SrcCurStart_CS;

  ModbusReadWriteComand_03_06_10(cPMT_SrcCurStart);
end;

procedure TTLD_Auto.NNPMT_SetPeltierTemp_CS(Params: String; Tag: Int64); //Установка целевой температуры из Commands
type
  TConvert = packed record
             case boolean of
               false: ( R: single );
               true:  ( W1,W2: word );
             end;
var
  t: TConvert;
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTNewSetTargetTemperature,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_SetPeltierTemp_CS;

  t.R:=PMT.TargetTempFromIni;
  t.R:=ConvertSingleToSingle(t.R);

  ModbusReadWriteComand_03_06_10(Format(cPMT_SetTargetTemp,[T.W1,T.W2]));
end;

procedure TTLD_Auto.NNPMTTargetTemp(Temp:single); //Установка целевой температуры из Control
type
  TConvert = packed record
             case boolean of
               false: ( R: single );
               true:  ( W1,W2: word );
             end;
var
  t: TConvert;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewSetTargetTemperature,[Temp]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMTChange;

  t.R:=Temp;
  t.R:=ConvertSingleToSingle(t.R);

  ModbusReadWriteComand_03_06_10(Format(cPMT_SetTargetTemp,[T.W1,T.W2]));
end;

procedure TTLD_Auto.NNPMTSetControlTime(aTime: word);
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewSetControlTime,[aTime]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMTChange;

  ModbusReadWriteComand_03_06_10(Format(cPMT_SetControlTime,[aTime]));
end;

procedure TTLD_Auto.NNPMTSetDevNumber(aNumber: DWord);
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsPMTNewSetDevNumber,[aNumber]),'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMTChange;

  ModbusReadWriteComand_03_06_10(Format(cPMT_SetDevNumber,[aNumber]));
end;

procedure TTLD_Auto.NNPMTGetDevNumber;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsPMTNewGetDevNumber,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTPMT_GetDevNumber;

  ModbusReadWriteComand_03_06_10(cPMT_GetDevNumber);
end;

{
procedure TTLD_Auto.NNScanBoardStartRead;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsScanStartRead,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTScanBoardStartRead;

  ModbusReadWriteComand_03_06_10(cScaner_StartRead);
end;

procedure TTLD_Auto.NNScanBoardReadBase;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsScanReadBase,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTScanBoardReadBase;

  ModbusReadWriteComand_03_06_10(cScaner_ReadBase);
end;

procedure TTLD_Auto.NNScanBoardReadBarCode;
begin
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsScanReadBarCode,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTScanBoardReadBarCode;

  ModbusReadWriteComand_03_06_10(Format(cScaner_ReadBarCode,[(Scaner.BarCodeLength+1) div 2]));
end;
}

procedure TTLD_Auto.NNScan_ReadBase_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsScanReadBase,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTScan_ReadBase_CS;

  ModbusReadWriteComand_03_06_10(cScanBoardS1);
end;

procedure TTLD_Auto.NNScan_Start_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsScanStartRead,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTScan_Start_CS;

  ModbusReadWriteComand_03_06_10(cScanBoardS2);
end;

procedure TTLD_Auto.NNScan_ReadBarCode_CS(Params: String; Tag: Int64);
begin
  SaveCallParams(Params, Tag);
  LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsScanReadBarCode,'',cMsgRead,cMsgPriorityInf);
  CNTQuery:=cCNTScan_ReadBarCode_CS;

  ModbusReadWriteComand_03_06_10(Format(cScanBoardS3,[(Scaner.BarCodeLength+1) div 2]));
end;

procedure TTLD_Auto.NNUserPanelReadBase;
var
  PanelCmd: word;
begin
  // Диалоговое окно
  if not Panel.DontUse and ModbusClient.Connected then
  begin
    ModbusClient.ReadHoldingRegisters(0,125,Panel.Input.WordArray); //cUserPanelReadBase
    if Panel.Input.DialogResult<>0 then
    begin
      Panel.Output.ProcessStatus:=Panel.Output.ProcessStatus.ClearBit(procstateInfoMessage);// and $FFF9;
      Panel.Output.ProcessStatus:=Panel.Output.ProcessStatus.ClearBit(procstateFailMessage);// and $FFF9;  Закрываем окно на панели
      //Panel.Output.AccidentNumber:=0;
      if CountActiveTimerMessages>0 then
        CloseAllTimerMessages:=True;
    end;
  end;

  // команда
  PanelCmd := Panel.Input.WordArray[0];
  if PanelCmd<>0 then
  begin
    if Assigned(OnGetPanelCommand) then OnGetPanelCommand(PanelCmd);
    if not Panel.DontUse and ModbusClient.Connected then ModbusClient.WriteRegister(0,0);
  end;
end;

procedure TTLD_Auto.NNUserPanelWrite1000;
begin
  //LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsUserPanelWrite1000,'',cMsgRead,cMsgPriorityInf);
  //CNTQuery:=cCNTUserPanelWrite1000;

  if not Panel.DontUse and ModbusClient.Connected then ModbusClient.WriteRegisters(1000,Panel.Output.Write1000);
end;

procedure TTLD_Auto.NNPanel_WinBase_CS(Params: String; Tag: Int64);
begin
  Panel.Output.Command:=panCmdNothing;
  if (Tag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
end;

procedure TTLD_Auto.NNPanel_WinMotors_CS(Params: String; Tag: Int64);
begin
  Panel.Output.Command:=panCmdMotors;
  if (Tag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
end;

procedure TTLD_Auto.NNPanel_WinScan_CS(Params: String; Tag: Int64);
begin
  Panel.Output.Command:=panCmdCheckAndScan;
  if (Tag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
end;

procedure TTLD_Auto.NNPanel_WinKTV1_CS(Params: String; Tag: Int64);
begin
  Panel.Output.D1_CurrentReaded:=0; Panel.Output.D1_KTVControl:=3;
  Panel.Output.D4_CurrentReaded:=0; Panel.Output.D4_KTVControl:=3;
//if ChangeData.DetectorCount=2 then DetNumber:=DetNumber-1; // исключение детектора 0 для 2-хдетекторного дозиметра при отрисовке в текущем MainForm

  Panel.Output.Command:=panCmdGetKTV1;
  if (Tag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
end;

procedure TTLD_Auto.NNPanel_WinKTV2_CS(Params: String; Tag: Int64);
begin
  Panel.Output.Command:=panCmdGetKTV2;
  if (Tag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
end;

procedure TTLD_Auto.NNPanel_WinPowerOff_CS(Params: String; Tag: Int64);
begin
  Panel.Output.Command:=panCmdPowerOff;
  if (Tag=cRunCommand) and (OnSuccesExecute<>Nil) then OnSuccesExecute;
end;

end.

