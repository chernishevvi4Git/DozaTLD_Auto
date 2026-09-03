unit uConst;

interface
const
// версия БД
  cDBVersion          = 92;
  cDefaultDB          = 'work';
//
  cCRLF               = #13#10;
// константы состояние температуры
  cTmpGreen           = 0;
  cTmpred             = 1;
  cTmpGray            = 2;
//
  cDVG                = 'DVG';
  cDozaTLD            = 'DozaTLD';
  cEmulatorID         = -100; // ID-считывателя в режиме эмуляции
  cTempProfileMult    = 10;   // пересчет в десятки градусов для записи в установку
  cSQLScriptName      = 'TLDDataBase_v';
  cCOMPortParity      = 'N';
// TLDState - состояние установки
  cBitNoConnection    = 0;    // бит - отсутствие связи с ТЛД
  cBitErr             = 1;    // бит - ошибка ТЛД
  cBitLoadingDet      = 2;    // бит - загрузкадетекторов
  cBitStoveHeating    = 3;    // бит - измерение, нагрев
  cBitStoveCooling    = 4;    // бит - измерение, остывание
// константы графиков
  cLeftBottomBorder   = 0;    // левая/нижняя граница графика
  cRightBottomBorder  = 299;  // правая грница графика
  cZoomStep           = 20;
  cOffsetStep         = 5;
// константы для подключения к БД postgres
  cPostgreServer      = 'Server';
  cPostgrePort        = 'Port';
  cPostgreDB          = 'Database';
  cPostgreUid         = 'Uid';
  cPostgrePWD         = 'Pwd';              // пароль к базе данных
  cPostgreDefaultDB   = 'postgres';         // имя базы данных по умолчанию
// таблицы БД
  cDBName             = 'datname';          // название БД
  cDBTableDosID       = 'tlddosimeterid';
  cDBTableDosType     = 'tlddosimetertype';
  cDBTableDosPart     = 'tlddosimeterpart';
  cDBTableDetType     = 'tlddetectortype';
  cDBTableDosRes      = 'tlddosimeterres';
  cDBTableDetRes      = 'tlddetectorres';
  cDBTableLog         = 'tldlog';
  cDBTableUser        = 'tlduser';
  cDBTableSettings    = 'tldsettings';
  cDBTableConfig      = 'tldconfig';
  cDBTableBackUp      = '_backup';
// tlddosimeterid
  cFullDosID          = 'fulldosid';        // виртуальное поле формируемое при выводе полного номера дозиметра с постфиксом
  cFieldDosID         = 'dosimeterid';      // ID дозиметра
  cFieldDosPostfix    = 'postfix';          // посфикс дозиметра
  cFieldDosTypeID     = 'dosimetertypeid';  // ID типа дозиметра
  cFieldDosType       = 'dosimetertype';    // тип дозиметра
  cFieldDosStatus     = 'status';
  cField_k1           = 'k1';               // коэф-ты
  cField_k2           = 'k2';               //
  cField_k3           = 'k3';               //
  cField_k4           = 'k4';               //
  cField_k5           = 'k5';               //
  cField_kgn          = 'kgn';              //
  cField_ecc1         = 'ecc1';             // для TLD-auto
  cField_ecc2         = 'ecc2';             //
  cField_ecc3         = 'ecc3';             //
  cField_ecc4         = 'ecc4';             //
  cFieldTldID         = 'tldid';
  cFieldPartID        = 'partid';
  cFieldRegTime       = 'regtime';
  cFieldVerTime       = 'vertime';
  cFieldOrg           = 'organization';
  cFieldDepartment    = 'department';
  cFieldLastMeasComment       = 'lastmeascomment';
  cFieldLastMeasResult        = 'lastmeasresult';
  cFieldLastMeasTime          = 'lastmeastime';
// tlddosimeterpart
  cFieldDosPartName           = 'partname';
  cFieldDosPartComment        = 'partcomment';
  cFieldDosPartCnt            = 'dosimetercnt';
// tlddosimetertype
  cFieldMeasVal               = 'measuredvalue';    // измеряемая величина
  cFieldDType1                = 'dtype1';           // тип детектора Д1
  cFieldDType2                = 'dtype2';           // тип детектора Д2
  cFieldDType3                = 'dtype3';           // тип детектора Д3
  cFieldDType4                = 'dtype4';           // тип детектора Д4
  cFieldFormula               = 'formula';          // формула расчета дозы
  cFieldError                 = 'error';            // погрешность
  cFieldFormulaId_Dos         = 'formula_id_dos';
  cFieldFormulaId_Val_1       = 'formula_id_val_1';
  cFieldFormulaId_Val_2       = 'formula_id_val_2';
  cFieldFormulaId_Val_3       = 'formula_id_val_3';
  cFieldFormulaId_Val_4       = 'formula_id_val_4';
  cFieldFormula_Err_k1_1      = 'formula_err_k1_1';
  cFieldFormula_Err_k2_1      = 'formula_err_k2_1';
  cFieldFormula_Err_k1_2      = 'formula_err_k1_2';
  cFieldFormula_Err_k2_2      = 'formula_err_k2_2';
  cFieldFormula_Err_k1_3      = 'formula_err_k1_3';
  cFieldFormula_Err_k2_3      = 'formula_err_k2_3';
  cFieldFormula_Err_k1_4      = 'formula_err_k1_4';
  cFieldFormula_Err_k2_4      = 'formula_err_k2_4';
  cFieldFormula_Err_1         = 'formula_err_1';
  cFieldFormula_Err_2         = 'formula_err_2';
  cFieldFormula_Err_3         = 'formula_err_3';
  cFieldFormula_Err_4         = 'formula_err_4';
  cDosTypeNone                = '-';
  cDosTypeDTU01Name           = 'DTU-01';
  cDosTypeDTU02Name           = 'DTU-02';
  cDosTypeEYEDName            = 'EYE-D';
  cDosTypeFingerRingGName     = 'Finger Ring G';
  cDosTypeFingerRingBGName    = 'Finger Ring BG';
  cDosTypeCoupleDTU1Name      = 'Couple DTU-1';
  cDosTypeTEST                = 'TEST';
  cFieldDBDescription         = 'description';

  cFieldVirt_Err_Hp_10g_Percent  = 'err_Hp_10g_Percent';
  cFieldVirt_Err_Hp_10n_Percent  = 'err_Hp_10n_Percent';
  cFieldVirt_Err_Hp_3_Percent    = 'err_Hp_3_Percent';
  cFieldVirt_Err_Hp_007_Percent  = 'err_Hp_007_Percent';
  cFieldVirt_Err_H_star_Percent  = 'err_H_star_Percent';
  cFieldVirt_Err_H_007_Percent   = 'err_H_007_Percent';
  cFieldVirt_Err_D_Percent       = 'err_D_Percent';

var // для перевода на другие языки (в том числе английский)
  cDosTypeNew             :String = 'Новый';
  cDosTypeTLD3Name        :String = 'ТЛД-3';
  cDosTypeDTL02Name       :String = 'ДТЛ-02';
  cDosTypeDTL022DetName   :String = 'ДТЛ-02(2 дет.)';
  cDosTypeDVNGMName       :String = 'ДВНГ-М';
const
// tlddetectortype
  cFieldDetTypeID             = 'detectortypeid';   // ID детектора
  cFieldDetType               = 'detectortype';     // тип детектора
  cFieldKMat                  = 'kmaterial';        // к-материала
  cTimePreheat                = 'time_preheat';     // время преднагрева
  cTempPreheat                = 'temp_preheat';     // температура преднагрева
  cTimeMeas                   = 'time_meas';        // время измерения
  cTempMeas                   = 'temp_meas';        // температура измерения
  cTimeBurn                   = 'time_burn';        // время отжига
  cTempBurn                   = 'temp_burn';        // температура отжига
  cSpeedHeating               = 'speed';            // скорость нагрева
  cDetPos1                    = 1;
  cDetPos2                    = 2;
  cDetPos3                    = 3;
  cDetPos4                    = 4;
  cNone                       = 'none';             // нет детектора
  cFieldTempProfile           = 'tempprofile';      // массив профиля нагрева
  cFieldKTV                   = 'ktv';              // массив КТВ
  cFieldCalcFon               = 'calcfon';
  cFieldCalcGaus              = 'calcgaus';
  cFieldCoefficient           = 'coefficient';
  cFieldMeasureTime           = 'measurmenttime';   // время измерения
  cFieldDetPosition           = 'position';         // позиция детектора в дозиметре
  cFieldDetTypeComment        = 'dettypecomment';   // комментарий к детектору
  cFieldMethod                = 'method';           // метод обработки
  cFieldDetMeasVal            = 'measval';          // измеряемая детектором величина
  cFieldK1Profile             = 'k1profile';        // коэффициент профиля к1
  cFieldK2Profile             = 'k2profile';        // коэффициент профиля к2
  cFieldDetKName              = 'kname';            // название коэффициента чувствительности
  cDetMat_None                = 'none';
  cDetMat_LiF_Mg_Ti           = 'LiF:Mg,Ti';
  cDetMat_LiF_Cu_P            = 'LiF:Mg,Cu,P';
  cDetMat_Al2O3               = 'Al2O3';
  cDetMat_6LiF_Mg_Ti          = '6LiF:Mg,Ti';
  cDetMat_7LiF_Mg_Ti          = '7LiF:Mg,Ti';
  cDetMat_LiF_Mg_Cu_P_thin    = 'LiF:Mg,Cu,P thin';
  cDetMat_TEST                = 'TEST';
  cDetTypes: array[0..6] of Ansistring = (cDetMat_LiF_Mg_Ti,
                                          cDetMat_LiF_Cu_P,
                                          cDetMat_Al2O3,
                                          cDetMat_6LiF_Mg_Ti,
                                          cDetMat_7LiF_Mg_Ti,
                                          cDetMat_LiF_Mg_Cu_P_thin,
                                          cDetMat_TEST
                                          );
  cDetType_None               = 0;
  cDetType_LiF_Mg_Ti          = 1;
  cDetType_LiF_Cu_P           = 2;
  cDetType_Al2O3              = 3;
  cDetType_6LiF_Mg_Ti         = 4;
  cDetType_7LiF_Mg_Ti         = 5;
  cDetType_TEST               = 6;
  cDetType_LiF_Mg_Cu_P_thin   = 7;
// состояния измерения
  cMeasStNormal               = 0;
  cMeasStCalibr               = 1;
  cMeasStCalibrComplete       = 2;
  cMeasStVerif                = 3;
  cMeasStVerifComplete        = 4;
  cMeasStFon                  = 5;
  cMeasStBurn                 = 6;
// методы обработки
  cMethod_None                = 'None';
  cMethod_Fitting             = 'Fitting';
  cMethod_Area_60_240         = 'Area[60-240]';
  cMethod_Area_10_280         = 'Area[10-280]';
  cMethod_User                = 'User';
  cMethodsCnt                 = 5;

  cMethodsArray : array [0..cMethodsCnt-1] of String = (
    cMethod_None,
    cMethod_Fitting,
    cMethod_Area_60_240,
    cMethod_Area_10_280,
    cMethod_User
  );
// измеряемые величины
  cNo_Val                     = 'none';
  cHp_10g                     = 'Hp(10)g';
  cHp_10n                     = 'Hp(10)n';
  cHp_3                       = 'Hp(3)';
  cHp_007                     = 'Hp(0.07)';
  cH_star                     = 'H*(10)';
  cH_007_dir                  = 'H`(0.07)';
  cD                          = 'D';

// константы измеряемых величин и кол-во детекторов
  c_not_found                    = -1 ;
  c_none                         = 0;
  cHp_10g_1d                     = 1;
  cHp_10g_2d                     = 2;
  cHp_10g_3d                     = 3;
  cHp_10g_4d                     = 4;
  cHp_10g_2d_Hp_10n_2d           = 5;
  cHp_10g_2d_Hp_10n_1d           = 6;
  cHp_10g_1d_Hp_10n_2d           = 7;
  cHp_10g_1d_Hp_10n_1d           = 8;
  cHp_007g_1d                    = 9;
  cHp_007g_2d                    = 10;
  cHp_007g_3d                    = 11;
  cHp_007g_4d                    = 12;
  cHp_3_1d                       = 13;
  cHp_3_2d                       = 14;
  cHp_3_3d                       = 15;
  cHp_3_4d                       = 16;
  cHp_star_g_1d                  = 17;
  cHp_star_g_2d                  = 18;
  cHp_star_g_3d                  = 19;
  cHp_star_g_4d                  = 20;
  cH_007_dir_g_1d                = 21;
  cH_007_dir_g_2d                = 22;
  cH_007_dir_g_3d                = 23;
  cH_007_dir_g_4d                = 24;
  cD_1d                          = 25;
  cD_2d                          = 26;
  cD_3d                          = 27;
  cD_4d                          = 28;
  cHp_10g_Hp_10n_Hp_007g_Hp_3    = 29; // 7776?, 7776H?
  cHp_007gb_1d                   = 30;
  cHp_007gb_2d                   = 31;
  cHp_007gb_3d                   = 32;
  cHp_007gb_4d                   = 33;

  cHp_10g_1d_Hp_007g_1d_Hp_3_1d  = 34; // ДТЛА-2 - скорректировать формулы потом
  cHp_10g_1d_Hp_007g_1d          = 35; // ДТЛА-1,0110,0770H - скорректировать формулы потом
  cHp_10g_2d_Hp_10n_2d_f6776     = 36; // 6776 - скорректировать формулы потом

  cDosMeasAllValCnt              = 37;

var
  cDetMeasValTxt_AllVal : array [0..cDosMeasAllValCnt-1] of String = ( // перевод в коде initialization
    //'Не найдено',                                                // -1
    'Нет',                                                         // 0
    'Hp(10) гамма 1 дет.(все тело)',                               // 1
    'Hp(10) гамма 2 дет.(все тело)',                               // 2
    'Hp(10) гамма 3 дет.(все тело)',                               // 3
    'Hp(10) гамма 4 дет.(все тело)',                               // 4
    'Hp(10) гамма 2 дет. Hp(10) нейтрон 2 дет.(все тело)',         // 5
    'Hp(10) гамма 2 дет. Hp(10) нейтрон 1 дет.(все тело)',         // 6
    'Hp(10) гамма 1 дет. Hp(10) нейтрон 2 дет.(все тело)',         // 7
    'Hp(10) гамма 1 дет. Hp(10) нейтрон 1 дет.(все тело)',         // 8
    'Hp(0.07) гамма 1 дет.(кожа)',                                 // 9
    'Hp(0.07) гамма 2 дет.(кожа)',                                 // 10
    'Hp(0.07) гамма 3 дет.(кожа)',                                 // 11
    'Hp(0.07) гамма 4 дет.(кожа)',                                 // 12
    'Hp(3) гамма+бета 1 дет.(хрусталик глаза)',                    // 13
    'Hp(3) гамма+бета 2 дет.(хрусталик глаза)',                    // 14
    'Hp(3) гамма+бета 3 дет.(хрусталик глаза)',                    // 15
    'Hp(3) гамма+бета 4 дет.(хрусталик глаза)',                    // 16
    'Амбиентный эквивалент H*(10) гамма 1 дет.',                   // 17
    'Амбиентный эквивалент H*(10) гамма 2 дет.',                   // 18
    'Амбиентный эквивалент H*(10) гамма 3 дет.',                   // 19
    'Амбиентный эквивалент H*(10) гамма 4 дет.',                   // 20
    'Направленный эквивалент H`(0.07) гамма 1 дет.',               // 21
    'Направленный эквивалент H`(0.07) гамма 2 дет.',               // 22
    'Направленный эквивалент H`(0.07) гамма 3 дет.',               // 23
    'Направленный эквивалент H`(0.07) гамма 4 дет.',               // 24
    'Поглощенная доза D 1 дет.',                                   // 25
    'Поглощенная доза D 2 дет.',                                   // 26
    'Поглощенная доза D 3 дет.',                                   // 27
    'Поглощенная доза D 4 дет.',                                   // 28
    'Hp(10) гамма, Hp(10) нейтрон, Hp(0.07), Hp(3)',               // 29
    'Hp(0.07) гамма+бета 1 дет.(кожа)',                            // 30
    'Hp(0.07) гамма+бета 2 дет.(кожа)',                            // 31
    'Hp(0.07) гамма+бета 3 дет.(кожа)',                            // 32
    'Hp(0.07) гамма+бета 4 дет.(кожа)',                            // 33
    'Hp(10) гамма, Hp(0.07) гамма, Hp(3) гамма',                   // 34
    'Hp(10) гамма, Hp(0.07) гамма',                                // 35
    'Hp(10) гамма 2 дет., Hp(10) нейтрон 2 дет. (6776)'            // 36
     );

const
  cDetMeasValTxt_Index : array [0..cDosMeasAllValCnt-1] of integer = (

   //c_not_found                  // -1
    c_none,                       // 0
    cHp_10g_1d,                   // 1
    cHp_10g_2d,                   // 2
    cHp_10g_3d,                   // 3
    cHp_10g_4d,                   // 4
    cHp_10g_2d_Hp_10n_2d,         // 5
    cHp_10g_2d_Hp_10n_1d,         // 6
    cHp_10g_1d_Hp_10n_2d,         // 7
    cHp_10g_1d_Hp_10n_1d,         // 8
    cHp_007g_1d,                  // 9
    cHp_007g_2d,                  // 10
    cHp_007g_3d,                  // 11
    cHp_007g_4d,                  // 12
    cHp_3_1d,                     // 13
    cHp_3_2d,                     // 14
    cHp_3_3d,                     // 15
    cHp_3_4d,                     // 16
    cHp_star_g_1d,                // 17
    cHp_star_g_2d,                // 18
    cHp_star_g_3d,                // 19
    cHp_star_g_4d,                // 20
    cH_007_dir_g_1d,              // 21
    cH_007_dir_g_2d,              // 22
    cH_007_dir_g_3d,              // 23
    cH_007_dir_g_4d,              // 24
    cD_1d,                        // 25
    cD_2d,                        // 26
    cD_3d,                        // 27
    cD_4d,                        // 28
    cHp_10g_Hp_10n_Hp_007g_Hp_3,  // 29
    cHp_007gb_1d,                 // 30;
    cHp_007gb_2d,                 // 31;
    cHp_007gb_3d,                 // 32;
    cHp_007gb_4d,                 // 33;
    cHp_10g_1d_Hp_007g_1d_Hp_3_1d,         // 34
    cHp_10g_1d_Hp_007g_1d,        // 35
    cHp_10g_2d_Hp_10n_2d_f6776    // 36
  );

  cDosMeasValCnt_1d           = 8;
  cDosMeasValCnt_2d           = 11;
  cDosMeasValCnt_3d           = 11;
  cDosMeasValCnt_4d           = 10;

  cDetMeasValTxt_1d : array [0..cDosMeasValCnt_1d-1] of integer = (
    c_none,                                 // 0
    cHp_10g_1d,                             // 1
    cHp_007g_1d,                            // 9
    cHp_007gb_1d,                           // 30;
    cHp_3_1d,                               // 13
    cHp_star_g_1d,                          // 17
    cH_007_dir_g_1d,                        // 21
    cD_1d                                   // 25
  );

  cDetMeasValTxt_2d : array [0..cDosMeasValCnt_2d-1] of integer = (
    c_none,                                 // 0
    cHp_10g_2d,                             // 2
    cHp_10g_1d_Hp_10n_1d,                   // 8
    cHp_007g_2d,                            // 10
    cHp_007gb_2d,                           // 31;
    cHp_3_2d,                               // 14
    cHp_star_g_2d,                          // 18
    cH_007_dir_g_2d,                        // 22
    cD_2d,                                  // 26
    cHp_10g_1d_Hp_007g_1d,                  // 35
    cHp_10g_2d_Hp_10n_2d_f6776              // 36
  );

  cDetMeasValTxt_3d : array [0..cDosMeasValCnt_3d-1] of integer = (
    c_none,                                 // 0
    cHp_10g_3d,                             // 3
    cHp_10g_2d_Hp_10n_1d,                   // 6
    cHp_10g_1d_Hp_10n_2d,                   // 7
    cHp_007g_3d,                            // 11
    cHp_007gb_3d,                           // 32;
    cHp_3_3d,                               // 15
    cHp_star_g_3d,                          // 19
    cH_007_dir_g_3d,                        // 23
    cD_3d,                                  // 27
    cHp_10g_1d_Hp_007g_1d_Hp_3_1d           // 34

  );

  cDetMeasValTxt_4d : array [0..cDosMeasValCnt_4d-1] of integer = (
    c_none,                                 // 0
    cHp_10g_4d,                             // 4
    cHp_10g_2d_Hp_10n_2d,                   // 5
    cHp_007g_4d,                            // 12
    cHp_007gb_4d,                           // 33;
    cHp_3_4d,                               // 16
    cHp_star_g_4d,                          // 20
    cH_007_dir_g_4d,                        // 24
    cD_4d,                                  // 28
    cHp_10g_Hp_10n_Hp_007g_Hp_3             // 29
  );

// коэффициенты
  cK1                         = 'k1';
  cK2                         = 'k2';
  cK3                         = 'k3';
  cK4                         = 'k4';
  cK5                         = 'k5';
  cKgn                        = 'kgn';
// формулы
  c_NoFormula                 = 0;
  cMeanD1D2D3D4_K1            = 1;
  cMeanD1D2D3_K1              = 2;
  cMeanD1D2_K1                = 3;
  cMeanD1_K1                  = 4;
  cMeanD2_K2                  = 5;
  cMeanD3_K3                  = 6;
  cMeanD4_K4                  = 7;
  cMeanD1D2D3_K1_D4_K2        = 8;
  cMeanD1D2_K1_D3D4_K2        = 9;
  cMeanD1D2_K1_D3_K2          = 10;
  cMeanD3D4_K2                = 11;
  cMeanD1_K1_D2_K2            = 12;
  cMeanD3D4_K2_D1D2_K1_Kgn    = 13;
  cMeanD3_K2_D1D2_K1_Kgn      = 14;
  cMeanD2D3_K2_D1_K1_Kgn      = 15;
  cMeanD2_K2_D1_K1_Kgn        = 16;

  cFormulasCnt                = 17;

  cArrayFormulasTxt           : array [0..cFormulasCnt-1] of String = (
    'No formula',                                     // 0
    'Mean(det1|det2|det3|det4)/k1',                   // 1
    'Mean(det1|det2|det3)/k1',                        // 2
    'Mean(det1|det2)/k1',                             // 3
    'det1/k1',                                        // 4
    'det2/k2',                                        // 5
    'det3/k3',                                        // 6
    'det4/k4',                                        // 7
    'Mean(det1|det2|det3)/k1+Mean(det4)/k2',          // 8
    'Mean(det1|det2)/k1+Mean(det3|det4)/k2',          // 9
    'Mean(det1|det2)/k1+det3/k2',                     // 10
    'Mean(det3|det4)/k2',                             // 11
    'det1/k1+det2/k2',                                // 12
    '[Mean(det3|det4)/k2-Mean(det1|det2)/k1]*kgn',    // 13
    '[det3/k2-Mean(det1|det2)/k1]*kgn',               // 14
    '[Mean(det2|det3)/k2-det1/k1]*kgn',               // 15
    '[det2/k2-det1/k1]*kgn'                           // 16
   );

  cArrayFormulasTxt_Index      : array [0..cFormulasCnt-1] of integer = (
    c_NoFormula,                               // 0
    cMeanD1D2D3D4_K1,                          // 1
    cMeanD1D2D3_K1,                            // 2
    cMeanD1D2_K1,                              // 3
    cMeanD1_K1,                                // 4
    cMeanD2_K2,                                // 5
    cMeanD3_K3,                                // 6
    cMeanD4_K4,                                // 7
    cMeanD1D2D3_K1_D4_K2,                      // 8
    cMeanD1D2_K1_D3D4_K2,                      // 9
    cMeanD1D2_K1_D3_K2,                        // 10
    cMeanD3D4_K2,                              // 11
    cMeanD1_K1_D2_K2,                          // 12
    cMeanD3D4_K2_D1D2_K1_Kgn,                  // 13
    cMeanD3_K2_D1D2_K1_Kgn,                    // 14
    cMeanD2D3_K2_D1_K1_Kgn,                    // 15
    cMeanD2_K2_D1_K1_Kgn                       // 16
  );


  cProfile_none = '250,100'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';

  cProfile_Res_none =       '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'+','
                          + '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0';

  cProfile_15_160_28_356_7_LiF = '430,500'+','
                          + '0,57,115,172,229,287,344,401,459,516,573,631,688,745,803,860,917,975,1032,1089,1147,1204,1261,1319,1376'+','
                          + '1433,1491,1548,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600'+','
                          + '1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600'+','
                          + '1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600'+','
                          + '1600,1600,1600,1600,1600,1600,1610,1620,1630,1640,1650,1660,1670,1680,1690,1700,1710,1720,1730,1740,1750,1761,1771,1781,1791'+','
                          + '1801,1811,1821,1831,1841,1851,1861,1871,1881,1891,1901,1911,1921,1931,1941,1951,1961,1971,1981,1991,2001,2011,2021,2031,2041'+','
                          + '2051,2062,2072,2082,2092,2102,2112,2122,2132,2142,2152,2162,2172,2182,2192,2202,2212,2222,2232,2242,2252,2262,2272,2282,2292'+','
                          + '2302,2312,2322,2332,2342,2352,2363,2373,2383,2393,2403,2413,2423,2433,2443,2453,2463,2473,2483,2493,2503,2513,2523,2533,2543'+','
                          + '2553,2563,2573,2583,2593,2603,2613,2623,2633,2643,2653,2664,2674,2684,2694,2704,2714,2724,2734,2744,2754,2764,2774,2784,2794'+','
                          + '2804,2814,2824,2834,2844,2854,2864,2874,2884,2894,2904,2914,2924,2934,2944,2954,2965,2975,2985,2995,3005,3015,3025,3035,3045'+','
                          + '3055,3065,3075,3085,3095,3105,3115,3125,3135,3145,3155,3165,3175,3185,3195,3205,3215,3225,3235,3245,3255,3266,3276,3286,3296'+','
                          + '3306,3316,3326,3336,3346,3356,3366,3376,3386,3396,3406,3416,3426,3436,3446,3456,3466,3476,3486,3496,3506,3516,3526,3536,3546';

  cTimePreheatVal_LiF       = '15';
  cTempPreheatVal_LiF       = '160';
  cTimeMeasVal_LiF          = '28';
  cTempMeasVal_LiF          = '356';
  cTimeBurnVal_LiF          = '0';
  cTempBurnVal_LiF          = '350';
  cSpeedHeatingVal_LiF      = '7';

  cProfile_30_140_100_240_20_240_1_Cu = '1500,500'+','
                          + '0,200,400,600,800,1000,1200,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400'+','
                          + '1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400'+','
                          + '1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1400,1405,1410,1415,1420,1425,1430,1435,1440,1445,1450,1455,1460,1465,1470'+','
                          + '1475,1480,1485,1490,1495,1500,1505,1510,1515,1520,1525,1530,1535,1540,1545,1550,1555,1560,1565,1570,1575,1580,1585,1590,1595'+','
                          + '1600,1605,1610,1615,1620,1625,1630,1635,1640,1645,1650,1655,1660,1665,1670,1675,1680,1685,1690,1695,1700,1705,1710,1715,1720'+','
                          + '1725,1730,1735,1740,1745,1750,1755,1760,1765,1770,1775,1780,1785,1790,1795,1800,1805,1810,1815,1820,1825,1830,1835,1840,1845'+','
                          + '1850,1855,1860,1865,1870,1875,1880,1885,1890,1895,1900,1905,1910,1915,1920,1925,1930,1935,1940,1945,1950,1955,1960,1965,1970'+','
                          + '1975,1980,1985,1990,1995,2000,2005,2010,2015,2020,2025,2030,2035,2040,2045,2050,2055,2060,2065,2070,2075,2080,2085,2090,2095'+','
                          + '2100,2105,2110,2115,2120,2125,2130,2135,2140,2145,2150,2155,2160,2165,2170,2175,2180,2185,2190,2195,2200,2205,2210,2215,2220'+','
                          + '2225,2230,2235,2240,2245,2250,2255,2260,2265,2270,2275,2280,2285,2290,2295,2300,2305,2310,2315,2320,2325,2330,2335,2340,2345'+','
                          + '2350,2355,2360,2365,2370,2375,2380,2385,2390,2395,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400'+','
                          + '2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400,2400';

  cTimePreheatVal_Cu        = '30';
  cTempPreheatVal_Cu        = '140';
  cTimeMeasVal_Cu           = '100';
  cTempMeasVal_Cu           = '240';
  cTimeBurnVal_Cu           = '20';
  cTempBurnVal_Cu           = '240';
  cSpeedHeatingVal_Cu       = '1';

  cProfile_4_120_22_328_5_328_31_Al = '310,500'+','
                          + '0,41,83,124,165,207,248,289,331,372,413,455,496,537,579,620,661,703,744,785,827,868,909,951,992'+','
                          + '1033,1075,1116,1157,1199,1200,1200,1200,1200,1200,1200,1200,1200,1200,1200,1210,1221,1231,1241,1252,1262,1272,1283,1293,1303'+','
                          + '1314,1324,1334,1345,1355,1365,1376,1386,1396,1407,1417,1427,1438,1448,1458,1469,1479,1489,1500,1510,1520,1531,1541,1551,1562'+','
                          + '1572,1582,1593,1603,1613,1624,1634,1644,1655,1665,1675,1686,1696,1706,1717,1727,1737,1748,1758,1768,1779,1789,1799,1810,1820'+','
                          + '1830,1841,1851,1861,1872,1882,1892,1903,1913,1923,1934,1944,1954,1965,1975,1985,1996,2006,2016,2027,2037,2047,2058,2068,2078'+','
                          + '2089,2099,2109,2120,2130,2140,2151,2161,2171,2182,2192,2202,2213,2223,2233,2244,2254,2264,2275,2285,2295,2306,2316,2326,2337'+','
                          + '2347,2357,2368,2378,2388,2399,2409,2419,2430,2440,2450,2461,2471,2481,2492,2502,2512,2523,2533,2543,2554,2564,2574,2585,2595'+','
                          + '2605,2616,2626,2636,2647,2657,2667,2678,2688,2698,2709,2719,2729,2740,2750,2760,2771,2781,2791,2802,2812,2822,2833,2843,2853'+','
                          + '2864,2874,2884,2895,2905,2915,2926,2936,2946,2957,2967,2977,2988,2998,3008,3019,3029,3039,3050,3060,3070,3081,3091,3101,3112'+','
                          + '3122,3132,3143,3153,3163,3174,3184,3194,3205,3215,3225,3236,3246,3256,3267,3277,3280,3280,3280,3280,3280,3280,3280,3280,3280'+','
                          + '3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280'+','
                          + '3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280,3280';

  cTimePreheatVal_Al        = '4';
  cTempPreheatVal_Al        = '120';
  cTimeMeasVal_Al           = '22';
  cTempMeasVal_Al           = '328';
  cTimeBurnVal_Al           = '5';
  cTempBurnVal_Al           = '328';
  cSpeedHeatingVal_Al       = '10';

  cProfile_30_140_100_240_20_240_1_TEST = '430,500'+','
                          + '0,57,115,172,229,287,344,401,459,516,573,631,688,745,803,860,917,975,1032,1089,1147,1204,1261,1319,1376'+','
                          + '1433,1491,1548,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600'+','
                          + '1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600'+','
                          + '1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600,1600'+','
                          + '1600,1600,1600,1600,1600,1600,1610,1620,1630,1640,1650,1660,1670,1680,1690,1700,1710,1720,1730,1740,1750,1761,1771,1781,1791'+','
                          + '1801,1811,1821,1831,1841,1851,1861,1871,1881,1891,1901,1911,1921,1931,1941,1951,1961,1971,1981,1991,2001,2011,2021,2031,2041'+','
                          + '2051,2062,2072,2082,2092,2102,2112,2122,2132,2142,2152,2162,2172,2182,2192,2202,2212,2222,2232,2242,2252,2262,2272,2282,2292'+','
                          + '2302,2312,2322,2332,2342,2352,2363,2373,2383,2393,2403,2413,2423,2433,2443,2453,2463,2473,2483,2493,2503,2513,2523,2533,2543'+','
                          + '2553,2563,2573,2583,2593,2603,2613,2623,2633,2643,2653,2664,2674,2684,2694,2704,2714,2724,2734,2744,2754,2764,2774,2784,2794'+','
                          + '2804,2814,2824,2834,2844,2854,2864,2874,2884,2894,2904,2914,2924,2934,2944,2954,2965,2975,2985,2995,3005,3015,3025,3035,3045'+','
                          + '3055,3065,3075,3085,3095,3105,3115,3125,3135,3145,3155,3165,3175,3185,3195,3205,3215,3225,3235,3245,3255,3266,3276,3286,3296'+','
                          + '3306,3316,3326,3336,3346,3356,3366,3376,3386,3396,3406,3416,3426,3436,3446,3456,3466,3476,3486,3496,3506,3516,3526,3536,3546';

  cTimePreheatVal_TEST      = '15';
  cTempPreheatVal_TEST      = '160';
  cTimeMeasVal_TEST         = '28';
  cTempMeasVal_TEST         = '356';
  cTimeBurnVal_TEST         = '0';
  cTempBurnVal_TEST         = '350';
  cSpeedHeatingVal_TEST     = '7';

// tlddosimeterres
  cFieldDosMeasID         = 'measurmentid';
  cFieldDose              = 'dose';
  cFieldKSI               = 'ksi';
  cFieldHp10g             = 'hp10g';
  cFieldHp10n             = 'hp10n';
  cFieldHp3               = 'hp3';
  cFieldHp007             = 'hp007';
  cFieldHstar             = 'hstar';
  cFieldH007              = 'h007';
  cFieldD                 = 'd';
  cFieldHp10g_err         = 'hp10g_err';
  cFieldHp10n_err         = 'hp10n_err';
  cFieldHp3_err           = 'hp3_err';
  cFieldHp007_err         = 'hp007_err';
  cFieldHstar_err         = 'hstar_err';
  cFieldH007_err          = 'h007_err';
  cFieldD_err             = 'd_err';
  cFieldSoftwareVer       = 'softwarever';
  cFieldTldUser           = 'tlduser';
  cFieldPersNumber        = 'personalnumber';
  cFieldFio               = 'fio';
  cFieldValidity          = 'validity';
  cFieldMeasComment       = 'meascomment';
  cFieldMeasState         = 'measstate';
  cFieldRadiationType     = 'radiationtype';
  cFieldCalibrationValue  = 'calibrationvalue';
  cFieldStringValidity    = 'stringvalidity';
  cFieldStringState       = 'stringstate';
  cFieldDetector1         = 'detector1';
  cFieldDetector2         = 'detector2';
  cFieldDetector3         = 'detector3';
  cFieldDetector4         = 'detector4';
  cFieldToDel             = 'to_del';
// tlddetectorres
  cFieldProcCurve         = 'processingcurve';
  cFieldAutoProc          = 'autoprocessing';
  cFieldTempProfileWrite  = 'tempprofilewrite';
  cFieldDetErr            = 'err';
  cFieldDetStatus         = 'status';
  cFieldDetComment        = 'comment';
  cFieldBt                = 'bt';
  cFieldBx0               = 'bx0';
  cFieldBy0               = 'by0';
  cFieldBxy0              = 'bxy0';
  cFieldBdy               = 'bdy';
  cFieldGm1               = 'gm1';
  cFieldGa1               = 'ga1';
  cFieldGsl               = 'gsl';
  cFieldDgm2              = 'dgm2';
  cFieldDga2              = 'dga2';
  cFieldGsr               = 'gsr';
  cFieldN1                = 'n1';
  cFieldN2                = 'n2';
  cFieldS                 = 's';
  cFieldBn1               = 'bn1';
  cFieldBn1Width          = 'bn1_width';
  cFieldBn2               = 'bn2';
  cFieldBn2Width          = 'bn2_width';
  cFieldPeakFound         = 'peakfound';
  cFieldFonFound          = 'fonfound';
// tldsettings
  cFieldKSLevel           = 'kslevel';
  cFieldKSDelta           = 'ksdelta';
  cFieldKFilter           = 'kfilter';
  cFieldKDevice           = 'kdev';
  cFieldDBVersion         = 'dbversion';
// tlduser
  cFieldUserName          = 'username';
  cFieldUserNameID        = 'usernameid';
  cFieldUserPermission    = 'userpermission';
  cFieldUserPassword      = 'userpassword';
  cFieldUserSettings      = 'usersettings';
// tldlog
  cFieldLogMsgTime        = 'msgtime';
  cFieldLogMsg            = 'msg';
// доступные по умолчанию типы дозиметров
  cDosTypeTLD3            = 1;
  cDosTypeDTL02           = 2;
  cDosTypeDTU01           = 3;
  cDosTypeDTU02           = 4;
  cDosTypeDVNGM           = 5;
  cDosTypeEYED            = 6;
  cDosTypeFingerRingG     = 7;
  cDosTypeFingerRingBG    = 8;
  cDosTypeCoupleDTU1      = 9;
     // 10 - Test
     // новые на DozaTLD_Auto
  cDosTypeAuto2           = 11; // потом уточнить
  cDosTypeAuto3           = 12; // потом уточнить
  cDosTypeAuto4           = 13; // потом уточнить

//шаги отображения картинок дозиметров
  cPictureDosNumber       = 1;
  cPictureDosLoadD1       = 2;
  cPictureDosLoadD2       = 3;
  cPictureDosLoadD3       = 4;
  cPictureDosLoadD4       = 5;
// константы в формуле
  cD1                     = 'd1';
  cD2                     = 'd2';
  cD3                     = 'd3';
  cD4                     = 'd4';
  cDet1                   = 'det1';
  cDet2                   = 'det2';
  cDet3                   = 'det3';
  cDet4                   = 'det4';
// позиции столика при начале измерения
  cTablePosStart          = 0;
  cTablePosFilter         = 1;
  cTablePosKSI            = 2;
  cTablePosD1             = 3;
  cTablePosD2             = 4;
  cTablePosD3             = 5;
  cTablePosD4             = 6;
  cTableMeasuring         = 7;
  cIrradiationD1          = 8;
  cIrradiationD2          = 9;
  cIrradiationD3          = 10;
  cIrradiationD4          = 11;
  cSource                 = 12;
//
  cTablePosMeasD1         = 0;
  cTablePosMeasD2         = 1;
  cTablePosMeasD3         = 2;
  cTablePosMeasD4         = 3;
  cTablePosSource         = 4;
  cTablePosLoadD1         = 5;
  cTablePosLoadD2         = 6;
  cTablePosLoadD3         = 7;
  cTablePosLoadD4         = 8;
  cTablePosNotDefined     = 31;
// состояние измерения
  cDosNotMeasured         = 0;
  cDosWaitLoad            = 1;
  cDosWaitMeasD1          = 2;
  cDosWaitMeasD2          = 3;
  cDosWaitMeasD3          = 4;
  cDosWaitMeasD4          = 5;
  cDosMeasInProgressD1    = 6;
  cDosMeasInProgressD2    = 7;
  cDosMeasInProgressD3    = 8;
  cDosMeasInProgressD4    = 9;
  cDosMeasFinishedD1      = 10;
  cDosMeasFinishedD2      = 11;
  cDosMeasFinishedD3      = 12;
  cDosMeasFinishedD4      = 13;
  cDosMeasErrorD1         = 14;
  cDosMeasErrorD2         = 15;
  cDosMeasErrorD3         = 16;
  cDosMeasErrorD4         = 17;
  cDosMeasStoppedD1       = 18;
  cDosMeasStoppedD2       = 19;
  cDosMeasStoppedD3       = 20;
  cDosMeasStoppedD4       = 21;
  cDosMeasWarning         = 22;
  cDosMeasError           = 23;
  cDosMeasFinished        = 24;
  cDosMeasAccepted        = 25;
  cDosMeasUserWarning     = 26;
// состояние дозиметра
  cDosUnknown             = -1;
  cDosCalibrated          = 0;
  cDosNotCalibrated       = 1;
  cDosDecommissioned      = 2;
  cDosNoFilter            = 1;       // отсутствие фильтра в дозиметре
// состояния детектора
  cDetNotMeasured         = 0;       // детектор не измерен
  cDetWaitLoad            = 1;       // загрузка детектора
  cDetWaitMeas            = 2;       // ожидание измерения
  cDetMeasInProgress      = 3;       // идет процесс измерения
  cDetMeasFinished        = 4;       // измерение завершено
  cDetMeasError           = 5;       // ошибка измерения
  cDetLost                = 6;       // детектор утерян
  cDetBroken              = 7;       // детектор сломан
  cDetSkiped              = 8;       // детектор пропущен (в отдельном поле комментарий должна указываться причина пропуска)
  cDetMeasStopped         = 9;       // измерение остановлено
  cDetProcessedError      = 10;      // ошибка обработки измерения
  cDetProcessedWarning    = 11;      // измерение обработано с предупреждением
  cDetProcessed           = 12;      // измерение обработано успешно
  cDetAcceptedError       = 13;      // измерение принято с ошибками
  cDetAcceptedWarning     = 14;      // измерение принято с замечаниями
  cDetAccepted            = 15;      // измерение принято без замечаний
  cEmulator               = 'Emulator'; // режим эмуляции
  cZeroDate               = '30.12.1899';
  cZeroDateTime           = '1899-12-30 00:00:00';
//  cDetMeasAccepted   = 12;      // измерение принято
//
//  cDetBitMeasFinished    = 0;   //1
//  cDetBitLoaded          = 1;   //2
//  cDetBitMeasError       = 2;   //4
//  cDetBitLost            = 3;   //8
//  cDetBitBroken          = 4;   //16
//  cDetBitSkiped          = 5;   //32
//  cDetBitMeasStopped     = 6;   //64
//  cDetBitProcessedError  = 7;   //128
//  cDetBitAccepted        = 8;   //256
  cAfterComma             = -3;
// константы фильтров
  cAND              = 'AND';
  cOR               = 'OR';
  cGreater          = '>';
  cLess             = '<';
  cEqual            = '=';
  cNotEqual         = '<>';
// константы индексов вкладок основного окна
  cPageMeasIndex        = 0;
  cPageProcessIndex     = 1;
  cPageDosIndex         = 2;
  cPageCalibrationIndex = 3;
  cPageSettingsIndex    = 4;
// константы индексов вкладок основного окна вкладки "Настройки"
  cPageSettingsDeviceIndex    = 0;
  cPageSettingsDatabaseIndex  = 1;
  cPageSettingsPermitIndex    = 2;
// константы индексов вкладок параметров измерения
  cPageMeasProcessMainParam   = 0;
  cPageMeasProcessDosParam    = 1;
  cPageMeasProcessIDKParam    = 2;
// константы индексов вкладок параметров дозиметра
  cPageDosMainParams    = 0;
  cPageDosIDK           = 1;
// константы индексов вкладок страницы старта измерений
  cPageStartMeas        = 0;
  cPageStartQueue       = 1;
  cPageStartIDK         = 2;
// режимы измерений
  //cStartSingleMeas      = 0;
  //cStartSeriaMeas       = 1;
  //cStartCalibration     = 2;
  //cTesting              = 3;
  //cBurning              = 4;
  //cIrradiation          = 5;
  //cGrading              = 6;
  //cRegistration         = 7;
// состояния пропуска детекторов
  cSkipDetectorAutoDisable = 0;
  cSkipDetectorLost        = 1;
  cSkipDetectorBroken      = 2;
  cSkipDetectorUser        = 3;
// названия файлов конфигурации
  cConfigFile                   = 'Config.ini';
  //cLogFile                      = 'LogFile.txt';
// секции ini-файла
  cSectionSettings              = 'Settings';
  cSectionGridColumnsMeas       = 'GridColumnsMeas';
  cSectionGridColumnsProcess    = 'GridColumnsProcess';
  cSectionGridColumnsCalibr     = 'GridColumnsCalibr';
  cSectionGridColumnsDos        = 'GridColumnsDos';
  cSectionComPortSettings       = 'COMPortSettings';
  cSectionDBSettings            = 'DBSettings';
  cSectionDB_ASIDK_Settings     = 'DB_ASIDK_Settings';
  cSectionFilter                = 'Filter';
  cSectionTest                  = 'Test';
  cSectionGridMeas              = 'GridMeas';
  cSectionGridProcess           = 'GridProcess';
  cSectionGridDos               = 'GridDos';
  cSectionGridCalibr            = 'GridCalibr';
  cSectionDeviceUnits           = 'DeviceUnits';
// константы ini-файла
  cMonitorTargetTemp            = 'Peltier.TargetTemp';
  cOld_AirHeat                  = 'Old_AirHeat';
  cUserPanelHost                = 'UserPanel.Host';
  cUserPanelMBAddr              = 'UserPanel.MBAddr';
  cUserPanelTimeOut             = 'UserPanel.TimeOut';
  cIrradiationEDR               = 'IrradiationEDR';
// settings
  cSettingsDeviceID             = 'DeviceID';
  cSettingsConfirmationRequest  = 'ConfirmationRequest';
  cSettingsReportWithDets       = 'ReportWithDets';
  cSettingsShowOriginalKTV      = 'ShowOriginalKTV';
  cSettingsShowGladeKTV         = 'ShowGladeKTV';
  cSettingsUseControlComment    = 'UseControlComment';
  cSettingsControlComment       = 'ControlComment';
  cSettingsAutoReset            = 'AutoReset';        // ресет установки после каждого измерения (должна быть поправлена прошивка)
  cSettingsLastUserWarning      = 'LastUserWarning';
  cSettingsDevFilterIndBit      = 'UseDeviceFilterIndicatorBit';
  cSettingsDosCntAutoCreatePart = 'DosCntAutoCreatePart';
  cSettingsSkipDetector         = 'SkipDetector';

  cFilterDosEnable              = 'FDosEnable';
  cFilterDosDosNumber           = 'FDosDosNumber';
  cFilterDosOrganization        = 'FDosOrganization';
  cFilterDosDepartment          = 'FDosDepartment';
  cFilterDosDosPath             = 'FDosDosPath';
  cFilterDosDosType             = 'FDosDosType';
  cFilterDosDosStatus           = 'FDosDosStatus';
  cFilterDosPersNumber          = 'FDosPersNumber';
  cFilterDosIDK                 = 'FDosIDK';
  cFilterDosTimeFrom            = 'FDosTimeFrom';
  cFilterDosTimeTo              = 'FDosTimeTo';
  cFilterDosComment             = 'FDosComment';
  cFilterDosDeviceID            = 'FDosDevicesID';
  cFilterProcessEnable          = 'FProcessEnable';
  cFilterProcessNumber          = 'FProcessDosNumber';
  cFilterProcessOrganization    = 'FProcessOrganization';
  cFilterProcessDepartment      = 'FProcessDepartment';
  cFilterProcessDosPath         = 'FProcessDosPath';
  cFilterProcessDosType         = 'FProcessDosType';
  cFilterProcessDosStatus       = 'FProcessDosStatus';
  cFilterProcessPersNumber      = 'FProcessPersNumber';
  cFilterProcessIDK             = 'FProcessIDK';
  cFilterProcessTimeFrom        = 'FProcessTimeFrom';
  cFilterProcessTimeTo          = 'FProcessTimeTo';
  cFilterProcessResult          = 'FProcessResult';
  cFilterProcessComment         = 'FProcessComment';
  cFilterProcessShowDelMeas     = 'FProcessShowDelMeas';
  cFilterProcessDeviceID        = 'FProcessDevicesID';

  cFilterCalibrEnable           = 'FCalibrEnable';

  cColumnMeasFullDosID          = 'ColumnMeasFullDosID';
  cColumnMeasID                 = 'ColumnMeasID';
  cColumnMeasDateTime           = 'ColumnMeasDateTime';
  cColumnMeasKSI                = 'ColumnMeasKSI';
  cColumnMeasDose               = 'ColumnMeasDose';
  cColumnMeasHp10g              = 'ColumnMeasHp10g';
  cColumnMeasHp10n              = 'ColumnMeasHp10n';
  cColumnMeasHp007              = 'ColumnMeasHp007';
  cColumnMeasHp3                = 'ColumnMeasHp3';
  cColumnMeasHStar              = 'ColumnMeasHStar';
  cColumnMeasH007               = 'ColumnMeasH007';
  cColumnMeasD                  = 'ColumnMeasD';
  cColumnMeasHp10g_Err          = 'ColumnMeasHp10g_Err';
  cColumnMeasHp10n_Err          = 'ColumnMeasHp10n_Err';
  cColumnMeasHp007_Err          = 'ColumnMeasHp007_Err';
  cColumnMeasHp3_Err            = 'ColumnMeasHp3_Err';
  cColumnMeasHStar_Err          = 'ColumnMeasHStar_Err';
  cColumnMeasH007_Err           = 'ColumnMeasH007_Err';
  cColumnMeasD_Err              = 'ColumnMeasD_Err';
  cColumnMeasValidity           = 'ColumnMeasValidity';
  cColumnMeasDosType            = 'ColumnMeasDosType';
  cColumnMeasDosReg             = 'ColumnMeasDosReg';
  cColumnMeasDosVer             = 'ColumnMeasDosVer';
  cColumnMeasDosStatus          = 'ColumnMeasDosStatus';
  cColumnMeasOrganization       = 'ColumnMeasOrganization';
  cColumnMeasDepartment         = 'ColumnMeasDepartment';
  cColumnMeasPartID             = 'ColumnMeasPartID';
  cColumnMeasComment            = 'ColumnMeasComment';
  cColumnMeasPersNumber         = 'ColumnMeasPersNumber';
  cColumnMeasFIO                = 'ColumnMeasFIO';
  cColumnMeasTLDUser            = 'ColumnMeasTLDUser';
  cColumnMeasLastMeasTime       = 'ColumnMeasLastMeasTime';
  cColumnMeasLastMeasComment    = 'ColumnMeasLastMeasComment';
  cColumnMeasTldID              = 'ColumnMeasTldID';

  cColumnProcessFullDosID       = 'ColumnProcessFullDosID';
  cColumnProcessID              = 'ColumnProcessID';
  cColumnProcessDateTime        = 'ColumnProcessDateTime';
  cColumnProcessKSI             = 'ColumnProcessKSI';
  cColumnProcessDose            = 'ColumnProcessDose';
  cColumnProcessHp10g           = 'ColumnProcessHp10g';
  cColumnProcessHp10n           = 'ColumnProcessHp10n';
  cColumnProcessHp007           = 'ColumnProcessHp007';
  cColumnProcessHp3             = 'ColumnProcessHp3';
  cColumnProcessHStar           = 'ColumnProcessHStar';
  cColumnProcessH007            = 'ColumnProcessH007';
  cColumnProcessD               = 'ColumnProcessD';
  cColumnProcessHp10g_Err       = 'ColumnProcessHp10g_Err';
  cColumnProcessHp10n_Err       = 'ColumnProcessHp10n_Err';
  cColumnProcessHp007_Err       = 'ColumnProcessHp007_Err';
  cColumnProcessHp3_Err         = 'ColumnProcessHp3_Err';
  cColumnProcessHStar_Err       = 'ColumnProcessHStar_Err';
  cColumnProcessH007_Err        = 'ColumnProcessH007_Err';
  cColumnProcessD_Err           = 'ColumnProcessD_Err';
  cColumnProcessValidity        = 'ColumnProcessValidity';
  cColumnProcessDosType         = 'ColumnProcessDosType';
  cColumnProcessDosReg          = 'ColumnProcessDosReg';
  cColumnProcessDosVer          = 'ColumnProcessDosVer';
  cColumnProcessDosStatus       = 'ColumnProcessDosStatus';
  cColumnProcessOrganization    = 'ColumnProcessOrganization';
  cColumnProcessDepartment      = 'ColumnProcessDepartment';
  cColumnProcessPartID          = 'ColumnProcessPartID';
  cColumnProcessComment         = 'ColumnProcessComment';
  cColumnProcessPersNumber      = 'ColumnProcessPersNumber';
  cColumnProcessFIO             = 'ColumnProcessFIO';
  cColumnProcessTLDUser         = 'ColumnProcessTLDUser';
  cColumnProcessLastMeasTime    = 'ColumnProcessLastMeasTime';
  cColumnProcessLastMeasComment = 'ColumnProcessLastMeasComment';
  cColumnProcessTldID           = 'ColumnProcessTldID';

  cColumnCalibrFullDosID       = 'ColumnCalibrFullDosID';
  cColumnCalibrID              = 'ColumnCalibrID';
  cColumnCalibrDateTime        = 'ColumnCalibrDateTime';
  cColumnCalibrKSI             = 'ColumnCalibrKSI';
  cColumnCalibrDose            = 'ColumnCalibrDose';
  cColumnCalibrK1              = 'ColumnCalibrK1';
  cColumnCalibrK2              = 'ColumnCalibrK2';
  cColumnCalibrK3              = 'ColumnCalibrK3';
  cColumnCalibrK4              = 'ColumnCalibrK4';
  cColumnCalibrK5              = 'ColumnCalibrK5';
  cColumnCalibrKgn             = 'ColumnCalibrKgn';
  cColumnCalibrHp10g           = 'ColumnCalibrHp10g';
  cColumnCalibrHp10n           = 'ColumnCalibrHp10n';
  cColumnCalibrHp007           = 'ColumnCalibrHp007';
  cColumnCalibrHp3             = 'ColumnCalibrHp3';
  cColumnCalibrHStar           = 'ColumnCalibrHStar';
  cColumnCalibrH007            = 'ColumnCalibrH007';
  cColumnCalibrD               = 'ColumnCalibrD';
  cColumnCalibrHp10g_Err       = 'ColumnCalibrHp10g_Err';
  cColumnCalibrHp10n_Err       = 'ColumnCalibrHp10n_Err';
  cColumnCalibrHp007_Err       = 'ColumnCalibrHp007_Err';
  cColumnCalibrHp3_Err         = 'ColumnCalibrHp3_Err';
  cColumnCalibrHStar_Err       = 'ColumnCalibrHStar_Err';
  cColumnCalibrH007_Err        = 'ColumnCalibrH007_Err';
  cColumnCalibrD_Err           = 'ColumnCalibrD_Err';
  cColumnCalibrValidity        = 'ColumnCalibrValidity';
  cColumnCalibrDosType         = 'ColumnCalibrDosType';
  cColumnCalibrDosReg          = 'ColumnCalibrDosReg';
  cColumnCalibrDosVer          = 'ColumnCalibrDosVer';
  cColumnCalibrDosStatus       = 'ColumnCalibrDosStatus';
  cColumnCalibrOrganization    = 'ColumnCalibrOrganization';
  cColumnCalibrDepartment      = 'ColumnCalibrDepartment';
  cColumnCalibrPartID          = 'ColumnCalibrPartID';
  cColumnCalibrComment         = 'ColumnCalibrComment';
  cColumnCalibrPersNumber      = 'ColumnCalibrPersNumber';
  cColumnCalibrFIO             = 'ColumnCalibrFIO';
  cColumnCalibrTLDUser         = 'ColumnCalibrTLDUser';
  cColumnCalibrLastMeasComment = 'ColumnCalibrLastMeasComment';
  cColumnCalibrTldID           = 'ColumnCalibrTldID';

  cColumnDosType                = 'ColumnDosType';
  cColumnDosStatus              = 'ColumnDosStatus';
  cColumnDosk1                  = 'ColumnDosk1';
  cColumnDosk2                  = 'ColumnDosk2';
  cColumnDosk3                  = 'ColumnDosk3';
  cColumnDosk4                  = 'ColumnDosk4';
  cColumnDosk5                  = 'ColumnDosk5';
  cColumnDoskgn                 = 'ColumnDoskgn';
  cColumnDosPartID              = 'ColumnDosPartID';
  cColumnDosReg                 = 'ColumnDosReg';
  cColumnDosVer                 = 'ColumnDosVer';
  cColumnDosOrganization        = 'ColumnDosOrganization';
  cColumnDosDepartment          = 'ColumnDosDepartment';
  cColumnDosLastMeasTime        = 'ColumnDosLastMeasTime';
  cColumnDosLastMeasResult      = 'ColumnDosLastMeasResult';
  cColumnDosLastMeasComment     = 'ColumnDosLastMeasComment';
  cColumnDosTldID               = 'ColumnDosTldID';

//  cUseUserWarningComment        = 'UseUserWarningComment';

  cTestDosName                  = '1_TEST';
  cTestDosTypeName              = 'TEST';
  cTestSourceUse                = 'SourceUse';
  cTestSourceTimeIncrease       = 'SourceTimeIncrease';
  cTestSourceTimeIncreaseCycle  = 'SourceTimeIncreaseCycle';
  cTestSourceKIncrease          = 'SourceKIncrease';
  cTestSourceTime               = 'SourceTime';
  cTestSourceDosimeterName      = 'SourceDosimeterName';
  cTestWriteModbusLog           = 'WriteModbusLog';

  cODBCDriver                   = 'ODBCDriver';
  cPGPass                       = 'PGPass';
  cPGPort                       = 'PGPort';
  cPGUid                        = 'PGUid';
  cServerIP                     = 'ServerIP';
  cPGDBName                     = 'DBName';
  cPGRestorePath                = 'PGRestorePath';
  cPGDumpPath                   = 'PGDumpPath';
  cPGBackupPath                 = 'PGBackupPath';
  cPGBackupDays                 = 'PGBackupDays';
  cPGTime                       = 'PGTime';

  cASIDK_Use                    = 'ASIDK_Use';
  cASIDK_ODBCDriver             = 'ASIDK_ODBCDriver';
  cASIDK_PGPass                 = 'ASIDK_PGPassASIDK';
  cASIDK_PGPort                 = 'ASIDK_PGPort';
  cASIDK_PGUid                  = 'ASIDK_PGUid';
  cASIDK_ServerIP               = 'ASIDK_ServerIP';
  cASIDK_DBName                 = 'ASIDK_DBName';
// функции БД АСИДК
  cASIDK_dozatld_gettlddosimeters  = 'asidk_dozatld_gettlddosimeters()';
  cASIDK_dozatld_whohas            = 'asidk_dozatld_whohas';
// поля БД АСИДК
  cASIDK_dosimeter_id              = 'dosimeter_id';
  cASIDK_id_person                 = 'id_person';
  cASIDK_id_fullname               = 'id_fullname';
  cASIDK_organization              = 'organization';
  cASIDK_department                = 'department';
// прочие константы
  cImgBtnErr                  = 'Error_btn.bmp';
  cImgBtnWarning              = 'Warning_btn.bmp';
  cImgBtnSettings             = 'Settings_btn.bmp';
  cComment                    = 'comment';
  cKDos                       = 'kdos';
  cProcessed                  = 'processed';
  cSourceDose                 = 'sourcedose';
  cCount                      = 'COUNT';
  cExcelApp                   = 'Excel.Application';
  cLogFileName                = 'LogFile.txt';
  cLogFileModbusName          = 'LogFileModbus.txt';
  cLogFileProfilerName        = 'LogFileProfiler.txt';
  {$IFDEF MSWINDOWS}
  cDozaReportBuilderFileName  = 'DozaReportBuilder.exe';
  {$ELSE}
  cDozaReportBuilderFileName  = 'DozaReportBuilder';
  {$ENDIF}

  cDozaReportMeasIDFile       = 'MeasID.txt';
  cQueue                      = 'Queue';
  cReport                     = 'Report';
  cCalibration                = 'Calibration';
  cDatraBaseLog               = 'DataBaseLog';
  cDozaReportBuilder          = 'DozaReportBuilder';
  cLog                        = 'Log';
  cExtTXT                     = '.txt';
  cExtCSV                     = '.csv';
  cExtMDOS                    = '.mdos';
  cExtMDET                    = '.mdet';
  cExtDOST                    = '.dost';
  cExtDETT                    = '.dett';
  cExtCFGT                    = '.cfgt';
  cExtMTD                     = '.mtd';
  cExtPDF                     = '.pdf';
  cExtSQL                     = '.sql';
  cPGExt                      = '.backup';
  cPGExt0                     = '.bk0';
  cEmptyData                  = '-';
  cNumberSymbol               = '№';
  cEmpty                      = 'Empty';
  cNull                       = 'null';
  cSuperUser                  = 'SuperUser';
  cSuperUserPermit            = 9223372036854775807;
  cFullPermit                 = 524287;
  cInvalidDoseValue           = -1;
  cSkipedDoseValue            = 0;
  cMarkedToDelMeas            = 1;
  cPenNormalWidth             = 1;
  cPenStrikeoutWidth          = 3;
  cColumnWidth_1              = 45;
  cColumnWidth_2              = 85;
  cColumnWidth_3              = 110;
  cColumnWidth_4              = 120;
  cColumnWidth_5              = 180;
  cColumnWidth_6              = 230;
  cColumnWidth_7              = 70;
  cEngineCntWarning           = 3;
  cCRCCntWarning              = 3;
  cImport                     = 'import';
  cExport                     = 'export';
  cBackup                     = 'backup';
  cFileNameDosimeter          = 'Dosimeter.csv';
  cFileNameDosimeterTypes     = 'DosimeterTypes.dost';{'DosimeterTypes.csv';}
  cFileNameDetectorTypes      = 'DetectorTypes.dett';{'DetectorTypes.csv';}
  cFolderLibrary              = 'Library';
  cFolderEmulator             = 'Emulator';
  cFolderMeasurements         = 'Measurements';
  cTranslatorServer           = 'Server';
  cTranslatorClient           = 'Client';
  cTranslatorPort             = 5520;
  cRemoteCaptureString        = 'DOZA-TLD_REMOTE_CAPTURE';
  cRemoteFreeString           = 'DOZA-TLD_REMOTE_FREE';
  // маски для определения позиций детекторов при расчете
  cDetMask_0001     = 1;
  cDetMask_0010     = 2;
  cDetMask_0011     = 3;
  cDetMask_0100     = 4;
  cDetMask_0101     = 5;
  cDetMask_0110     = 6;
  cDetMask_0111     = 7;
  cDetMask_1000     = 8;
  cDetMask_1001     = 9;
  cDetMask_1010     = 10;
  cDetMask_1011     = 11;
  cDetMask_1100     = 12;
  cDetMask_1101     = 13;
  cDetMask_1110     = 14;
  cDetMask_1111     = 15;
// массивы
  cDetMeasValCnt    = 8;
  cDetKCnt          = 5;
  cArrayDetMeasVal  : array [0..cDetMeasValCnt-1] of String = (cNo_Val,cHp_10g,cHp_10n,cHp_3,cHp_007,cH_star,cH_007_dir,cD);
  cArrayDetK        : array [0..cDetKCnt-1] of String = (cNo_Val,cK1,cK2,cK3,cK4);

  cNextStep         = 1;
  cPreviousStep     = 0;
// оценка контрольной суммы
  cKSNormal               = 0;
  cKSNotInRange           = 1;
  cKSFilterInstalled      = 2;
// шаги измерения дозиметра
  cStepDosMeasD1          = 0;
  cStepDosMeasD2          = 1;
  cStepDosMeasD3          = 2;
  cStepDosMeasD4          = 3;
  cStepDosMeasFinished    = 4;

// Взаимодействие с пользователем
  cUI_DarkCurrent         = 01; // Ошибка DarkCurrent (темновой ток вне нормы)
  cUI_CICurrent           = 02; // Ошибка CICurrent (ток при засветке светодиодом вне нормы)
  cUI_BadScan             = 03; // Ошибка BadScan - 0 - при считывании штрихкода
  cUI_AlgorithmErr        = 04; // Ошибка в алгоритме (Не определён статус дозиметра - найден или не найден в БД)
  cUI_ErrCassAB_Up        = 05; // Ошибка в плате управления моторами - не поднята одна из кассет после подачи соответствующих комманд
  cUI_ErrCassA_Down       = 06; // Кассетница А не обнаружена
  cUI_ErrCassB_Down       = 07; // Кассетница Б не обнаружена
  cUI_EndMeasure          = 08; // Закончено измерение
  cUI_LowFlow             = 09; // Прокачки нет
  //cUI_UnknownFail         = 10; // Ошибка нераспознанная
  cUI_MotorsBoardFail     = 11; // Ошибка самодиагностики платы управления моторами (Status = 1 - EEPROM failure)
  cUI_MotorsBoardConFail  = 12; // Потеря соединения
  cUI_AirHeatBoardConFail = 13; // Потеря соединения
  cUI_MonitorBoardConFail = 14; // Потеря соединения
  cUI_PMTBoardConFail     = 15; // Потеря соединения
  cUI_ScanBoardConFail    = 16; // Потеря соединения
  cUI_PMTNewConFail       = 17; // Потеря соединения
  cUI_COMPortFail         = 18; // Потеря соединения со всеми приборами на COM-порту
  cUI_UIPanelConFail      = 19; // Потеря соединения с панелью
  cUI_FilterFail          = 20; // Не установлен фильтродержатель
  cUI_StopByUser          = 21; // Измерение остановлено пользователем

// команды управления установкой
  cRunNone                = -2; // Для Tag - Признак стёртости (работать должно как cRunSingle)
  cRunCommand             = 0;  // Для Tag - Признак выполнения команды в серии (для вызова следующей команды)
  cRunSingle              = -1; // Для Tag - Признак выполнения одной команды (не серии), для вызовов из Control
  // Общие
  cCNTCommonNothing       = 100; // Ничего не делать
  cCNTCommon              = 101; // Алгоритмическая команда из TLDCommandSeries (без привязки к COM-порту)

  // старые
  cCNTStartMeas           = 201; // - НАЧАТЬ ИЗМЕРЕНИЕ
  cCNTStopMeas            = 202; // - ОСТАНОВИТЬ ИЗМЕРЕНИЕ
  cCNTReadMeasResult      = 203; // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ
  cCNTRotateTable         = 204; // - ПОВЕРНУТЬ СТОЛ
  cCNDReadDeviceParam     = 205; // - СЧИТЫВАНИЕ БЛОКА ОПИСАНИЯ ПРИБОРА
  cCNTWriteDevID          = 206; // - ЗАПИСЬ ID УСТАНОВКИ

  // MotorsBoard
  cCNTMotorsGetDeviceID   = 03; // Считывание номера установки
  //cCNTMotorsC1            = 04; // Опрос моторов <из алгоритмов>
  cCNTMotorsSetPosition   = 05; // УСТАНОВИТЬ ПОЛОЖЕНИЕ (POINT) ШАГОВОГО ДВИГАТЕЛЯ (N)
  cCNTMotors_ReadBase_CS  = 06; // ПРОЧИТАТЬ ОСНОВНЫЕ ПАРАМЕТРЫ ПЛАТЫ УПРАВЛЕНИЯ ДВИГАТЕЛЯМИ
  cCNTMotorsReadParams1   = 07; // ПРОЧИТАТЬ ДОП1 ПАРАМЕТРЫ ПЛАТЫ УПРАВЛЕНИЯ ДВИГАТЕЛЯМИ
  cCNTMotorsReadParams2   = 08; // ПРОЧИТАТЬ ДОП2 ПАРАМЕТРЫ ПЛАТЫ УПРАВЛЕНИЯ ДВИГАТЕЛЯМИ
  cCNTMotorsReadProgress  = 09; // ЧИТАТЬ ПРОЦЕНТ ВЫПОЛНЕНИЯ КОМАНДЫ
  cCNTMotorsStop          = 10; // Остановка выполнения команды
  cCNTMotorsInit          = 11; // Инизиализация ШД
  cCNTMotorsInit1_251_CS  = 12; // Инизиализация 251 ШД 1 <из алгоритмов>
  cCNTMotorsInit1_252_CS  = 13; // Инизиализация 252 ШД 1 <из алгоритмов>
  cCNTMotorsInit1_253_CS  = 14; // Инизиализация 253 ШД 1 <из алгоритмов>
  cCNTMotorsInit2_253_CS  = 15; // Инизиализация 253 ШД 1 <из алгоритмов>
  cCNTMotorsInit3_253_CS  = 16; // Инизиализация 253 ШД 1 <из алгоритмов>
  cCNTMotorsInit4_253_CS  = 17; // Инизиализация 253 ШД 1 <из алгоритмов>
  cCNTMotorsInit5_253_CS  = 18; // Инизиализация 253 ШД 1 <из алгоритмов>
  cCNTMotors_PL1On_CS     = 19; // Включить питание линии 1
  cCNTMotors_PL1Off_CS    = 20; // Выключить питание линии 1
  cCNTMotors_PL2On_CS     = 21; // Включить питание линии 2
  cCNTMotors_PL2Off_CS    = 22; // Выключить питание линии 2
  cCNTMotors_PL3On_CS     = 23; // Выключить питание линии 1
  cCNTMotors_PL3Off_CS    = 24; // Выключить питание линии 2
  cCNT_PLChange           = 25; // Изменение по питанию - к перечитыванию

  // AirHeatBoard
  // Old Version
  cCNTAirHeatWriteProfile_OLD = 31;  // Команда записи термопрофиля <из алгоритмов>
  cCNTAirHeatA1_OLD           = 32;  // Команда чтения <из алгоритмов>
  cCNTAirHeatA2_OLD           = 33;  // Старт измерения <из алгоритмов>
  cCNTAirHeat_Stop_CS         = 34;  // Принудительная остановка измерения <из алгоритмов>
  cCNTAirHeatA4_OLD           = 35;  // Запись профиля <из алгоритмов>
  cCNTAirHeatReadAll_OLD      = 36;  // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ПЛАТЫ НАГРЕВАТЕЛЯ ВОЗДУХА
  cCNTAirHeatA5_inKTV_OLD     = 37;  // связка чтения температуры и чтения КТВ <из алгоритмов>
  cCNTAirHeatA6_OLD           = 38;  // Ожидание остывания по температуре <из алгоритмов>
  cCNTAirHeatA7_OLD           = 39;  // Установить термопрофиль комнатный для проверки потока
  // New Version
  cCNTAirHeat_WriteProfile_CS = 41;  // Команда записи термопрофиля <из алгоритмов>
  cCNTAirHeat_Start_CS        = 42;  // Старт измерения <из алгоритмов>
  cCNTAirHeat_ReadInput_CS    = 43;  // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ПЛАТЫ НАГРЕВАТЕЛЯ ВОЗДУХА
  cCNTAirHeat_ReadHolding_CS  = 44;  // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ПЛАТЫ НАГРЕВАТЕЛЯ ВОЗДУХА
  cCNTAirHeat_ReadInKTV_CS    = 45;  // связка чтения температуры и чтения КТВ <из алгоритмов>
  cCNTAirHeat_Cooling_CS      = 48;  // Ожидание остывания по температуре <из алгоритмов>

  // Monitor
  cCNTMonitorInit             = 80;  //  Инициализация
  cCNTMonitorM1               = 81;  //  Команда чтения <из алгоритмов>
  cCNTMonitorM2               = 82;  //  Конец измерения К.И. (“выключение”) <из алгоритмов>
  cCNTMonitorM3               = 83;  //  Измерение К.И. (“включение”) <из алгоритмов>
  cCNTMonitorM4               = 84;  // Инициализация Пельтье <из алгоритмов>
  cCNTMonitorReadAll          = 85;  // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ МОНИТОРА

  // PMTBoard
  cCNTPMTBoardP1              = 51;  //  Команда чтения <из алгоритмов>
  cCNTPMTBoardReadAll         = 55;  // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ
  cCNTPMTBoardWriteAll        = 56;  // ЗАПИСАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ

  // PMT
  cCNTPMT_ReadBase_SC         = 151;  //  Команда чтения базы
  cCNTPMT_ReadChans_SC        = 152;  //  Команда чтения числа регистров массива - с продолжением чтения КТВ по необходимости
  cCNTPMTReadKTV              = 153;  //  Команда чтения КТВ
  cCNTPMT_Start_CS            = 154;  //  Команда Старт
  cCNTPMT_SetTime_CS          = 155;  //  Команда установки времени (и автостарт)
  cCNTPMTChange               = 156;  //  Включить - выключить LED или элемент Пельтье 1-Led1, 2-Led2, 3- Пельтье  или что-то ещё из Control
  cCNTPMT_DarkCurStart_CS     = 157;  // Запуск измерения темнового тока
  cCNTPMT_SrcCurStart_CS      = 158;  // Запуск измерения тока от контрольного источника
  cCNTPMT_SetPeltierTemp_CS   = 159;  // Установка целевой температуры
  cCNTPMT_GetDevNumber        = 160;  // Чтение номера установки
  cCNTPMT_WaitDone_CS         = 161;  //  Команда Старт

  // ScanBoard
  cCNTScan_ReadBase_CS        = 61;  //  Команда чтения <из алгоритмов>
  cCNTScan_Start_CS           = 62;  //  Начать считывание штрихкода <из алгоритмов>
  cCNTScan_ReadBarCode_CS     = 63;  //  Считывание штрихкода известной длины <из алгоритмов>
  //cCNTScanBoardStartRead      = 65;  // ЗАПУСК ЧТЕНИЯ ШТРИХКОДА
  //cCNTScanBoardReadBase       = 66;  // ПРОЧИТАТЬ СОСТОЯНИЕ ГОТОВНОСТИ ВЫПОЛНЕНИЯ ЧТЕНИЯ ШТРИХКОДА
  //cCNTScanBoardReadBarCode    = 67;  // ВЕРНУТЬ ШТРИХКОД

  // UserPanel (MODBUS TCP)
  cCNTUserPanelReadBase       = 221;  //  Команда чтения регистров MODBUS TCP панели
  cCNTUserPanelWrite1000      = 222;  //  Команда записи пула регистров с 1000 по MODBUS TCP в панель

  panCmdNothing               = 0;    //  Команда панели на переключение окна
  panCmdMotors                = 1;    //  Команда панели на переключение окна
  panCmdCheckAndScan          = 2;    //  Команда панели на переключение окна
  panCmdGetKTV1               = 3;    //  Команда панели на переключение окна
  panCmdGetKTV2               = 4;    //  Команда панели на переключение окна
  panCmdPowerOff              = 5;    //  Команда панели на переключение окна

  cPanelStatusBit_DisConnected = word($0001);

  //cCNTReadMeasResultP0    = 0;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 0
  //cCNTReadMeasResultP1    = 1;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 1
  //cCNTReadMeasResultP2    = 2;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 2
  //cCNTReadMeasResultP3    = 3;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 3
  //cCNTReadMeasResultP4    = 4;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 4
  //cCNTReadMeasResultP5    = 5;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 5
  //cCNTReadMeasResultP6    = 6;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 6
  //cCNTReadMeasResultP7    = 7;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 7
  //cCNTReadMeasResultP8    = 8;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 8
  //CCNTReadMeasResultP9    = 9;  // - СЧИТЫВАНИЕ РЕЗУЛЬТАТОВ ИЗМЕРЕНИЙ ЧАСТЬ 9
  //
// символы юникода
//  cUnicodeSymbol_Dot      = '2022';
//  cUnicodeSymbol_Delta    = '0394';
//  cUnicodeSymbol_Gamma    = '03B3';
//  cUnicodeSymbol_Neutron  = '006E';
//  cUnicodeSymbol_Beta     = '03B2';

  cuUnicodeSymbol_Dot      = '•';
  cuUnicodeSymbol_Delta   = 'Δ';
  cuUnicodeSymbol_Gamma    = 'γ';
  cuUnicodeSymbol_Neutron  = 'n';
  cuUnicodeSymbol_Beta     = 'β';

//
  cReport_tld_dosimeter_res_pdf   = 'tld_dosimeter_res_pdf';
  cReport_tld_dosimeter_coef_pdf  = 'tld_dosimeter_coef_pdf';

// типы излучения
  cRadTypeGamma           = 'gamma';
  cRadTypeNeutron         = 'neutron';
// коды клавиш
  cVK_Enter = $0D;          //  кнопка Enter

// мвксимальное число неответов, после чего алгоритм переходит в ожидание
  MaxNoAnswer = 10;

var
  cDosTypes: array[0..10] of AnsiString;
implementation
uses uLanguages, SysUtils;

var
  i: integer;

initialization
// перевод строковых констант
  ReadLangIniString(SECT_Res,'cDosTypeNew',cDosTypeNew);
  ReadLangIniString(SECT_Res,'cDosTypeTLD3Name',cDosTypeTLD3Name);
  ReadLangIniString(SECT_Res,'cDosTypeDTL02Name',cDosTypeDTL02Name);
  ReadLangIniString(SECT_Res,'cDosTypeDTL022DetName',cDosTypeDTL022DetName);
  ReadLangIniString(SECT_Res,'cDosTypeDVNGMName',cDosTypeDVNGMName);
  cDosTypes[0]  := cDosTypeTLD3Name;
  cDosTypes[1]  := cDosTypeDTL02Name;
  cDosTypes[2]  := cDosTypeDTL022DetName;
  cDosTypes[3]  := cDosTypeDTU01Name;
  cDosTypes[4]  := cDosTypeDTU02Name;
  cDosTypes[5]  := cDosTypeDVNGMName;
  cDosTypes[6]  := cDosTypeEYEDName;
  cDosTypes[7]  := cDosTypeFingerRingGName;
  cDosTypes[8]  := cDosTypeFingerRingBGName;
  cDosTypes[9]  := cDosTypeCoupleDTU1Name;
  cDosTypes[10] := cDosTypeTEST;
//  cDetMeasValTxt_AllVal : array [0..cDosMeasAllValCnt-1] of String = (
  for i := Low(cDetMeasValTxt_AllVal) to High(cDetMeasValTxt_AllVal) do
    ReadLangIniString(SECT_Res,'cDetMeasValTxt_AllVal['+intToStr(i)+']',cDetMeasValTxt_AllVal[i]);

  ReadLangIniString(SECT_Res,'cDosTypeNew',cDosTypeNew);
end.
