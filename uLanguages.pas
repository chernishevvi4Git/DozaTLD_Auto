unit uLanguages;

interface
uses Forms, IniFiles, Classes;

var
  iParamNumber: integer; // переменная для перебора параметров запуска программы
  AppParamString : String = ''; // параметры запуска программы
  UseLanguageFile: boolean = false; // признак использования языковых модификаций

// РЕСУРСЫ
// Расчётный модуль
  rsPeakNotFound                : String = 'Пик не найден';
  rsCheckFonBegin               : String = 'Проверьте начало фоновой функции (By0)';
  rsCheckFonSlant               : String = 'Проверьте наклон фоновой функции (Bt)';
  rsCheckFonCentre              : String = 'Проверьте положение фоновой функции (Bx0)';
  rsCheckFonRight               : String = 'Проверьте правый край фоновой функции (Bx0,Bt)';
  rsCheckPeak5CentreRight       : String = 'Проверьте положение найденного пика, отклонение вправо (GM1)';
  rsCheckPeak5CentreLeft        : String = 'Проверьте положение найденного пика, отклонение влево (GM1)';
  rsCheckPeak4CentreRight       : String = 'Проверьте положение паразитного пика 4, отклонение вправо (DGM2)';
  rsCheckPeak4CentreLeft        : String = 'Проверьте положение паразитного пика 4, отклонение влево (DGM2)';
  rsCheckPeakGA1min             : String = 'Детектор не накопил значимой дозы';
  rsCheckPeakGA1max             : String = 'Детектор зафиксировал очень большое значение дозы';
  rsCheckPeakDGA2               : String = 'Проверьте амплитуду паразитного пика 4 (DGA2)';
  rsCheckPeakGSL                : String = 'Проверьте отклонение левой стороны пиков (GSL)';
  rsCheckPeakGSR                : String = 'Проверьте отклонение правой стороны пиков (GSR)';
  rsFonBy0TooLow                : String = 'Нет фоновых импульсов на начальном участке нагрева [By0]';
  rsFonBy0TooHigh               : String = 'Избыточно много импульсов на начальном участке нагрева [By0]\n(возможно засветка детектора)';
  rsFonBx0TooLow                : String = 'Необычно ранний подъём фоновой функции [Bx0]\n(возможно фоновая функция определена некорректно - по левой стороне пика)';
  rsFonBx0TooHigh               : String = 'Необычно поздний подъём фоновой функции [Bx0]\n(возможно фоновая функция определена некорректно - по правой стороне пика)';
  rsFonBtNegative               : String = 'Неправильный уклон фоновой функции [Bt]\n(вероятно фоновая функция определена по неправильно выбранным точкам)';
  rsFonBtTooLow                 : String = 'Необычно сильный подъём фоновой функции [Bt]\n(возможно фоновая функция определена некорректно - по правой стороне пика)';
  rsFonBtTooHigh                : String = 'Необычно слабый подъём фоновой функции [Bt]\n(возможно фоновая функция определена некорректно - по левой стороне пика)';
  rsDozaNotFound                : String = 'В отклике детектора не обнаружены признаки дозы';
  rsFonAfterPeakTooRight        : String = 'Правая сторона пика приближается к краю';
  rsFonAfterPeakAbsent          : String = 'Правая сторона пика выходит за край';
  rsExitNotifyIfManualChange    : String = 'Вы корректировали результаты автоматического расчёта\nСохранить изменения при выходе из рассчётного модуля?';
  rsFailureDetectorLoad         : String = ' Отказ загрузки дозиметра ';
  rsUserOptions                 : String = 'Пользовательские настройки';
  rsAutoCalc                    : String = '(авторасчёт)';
  rsManualChanges               : String = '(ручные изменения)';
  rsAutoCalcFromDB              : String = '(авторасчёт из базы данных)';
  rsManualChangesFromDB         : String = '(ручные изменения из базы данных)';
  rsBackgroundFailure           : String = 'Фон не корректен';
  rsPeakSimulated               : String = 'Пик имитирован';
  rsWarning                     : String = 'Предупреждение';
  rsCommonView                  : String = 'Общий вид';
  rsBackgroundView              : String = 'Фоновая функция';
  rsPeakView                    : String = 'Функция пика';
  rsYes                         : String = 'Да';
  rsNo                          : String = 'Нет';
  rsCancel                      : String = 'Отмена';
  rsChartCalcTitle              : String = 'Выбор графиков  ';
  rsBrookenMeasure              : string = 'Измерение инвалидировано пользователем';
  rsFitFonTiltle                : string = 'Фитирование фона';
  rsFitPeakTiltle               : string = 'Фитирование пика';
  rsSuquare                     : String = 'Геометрическая площадь зоны интереса';
  rsCalcFormError               : String = 'Ошибка в %s: %s'; // %s - имя процедуры/поля, %s - текст исключения

// База данных
  rsDBNoConnection              : String = 'Нет связи с базой данных';
  rsDBConnectionFault           : String = 'Не удалось подключиться к базе данных';
  rsDBConnectionFault_ASIDK     : String = 'Не удалось подключиться к базе данных АСИДК';
// Окно "О программе"
  rsVersion                     : String = 'Версия';
  rsInformation                 : String = 'ПО предназначено для работы в составе комплекса дозиметрического термолюминесцентного «ДОЗА-ТЛД»';
// COM-порт
  rsOpenPort                    : String = 'Порт открыт';
  rsCantOpenPort                : String = 'Не удалось открыть порт';
  rsPortInitError               : String = 'Не удалось инициализировать порт';
  rsEmulator                    : String = 'Эмуляция';
// Пользователи и права
  rsIncorrectLoginPass          : String = 'Неверно указан логин или пароль';
  rsFIO                         : String = 'ФИО';
  rsCantDelCurrentUser          : String = 'Невозможно удалить текущего пользователя';
  rsUserAlreadyExist            : String = 'Пользователь с таким имененм уже существует';
  rsUserNameIsNotValid          : String = 'Имя пользователя зарезервировано системой. Укажите новое имя';
// Дозиметры
  rsDosimeter                   : String = 'Дозиметр';
  rsDosimeterType               : String = 'Тип';
  rsDosCalibrated               : String = 'Откалиброван';
  rsDosNotCalibrated            : String = 'Не откалиброван';
  rsDosDecommissioned           : String = 'Выведен из эксплуатации';
  rsDosUnknown                  : String = 'Неопределенное состояние';
  rsDosDose                     : String = 'Доза';
  rsDosK                        : String = 'K-дозиметра';
  rsDosMeasStatus               : String = 'Статус измерения';
  rsDosStatus                   : String = 'Статус дозиметра';
// Детекторы
  rsD                           : String = 'Д';
  rsDetector                    : String = 'Детектор';
  rsDetector1                   : String = 'Детектор1';
  rsDetector2                   : String = 'Детектор2';
  rsDetector3                   : String = 'Детектор3';
  rsDetector4                   : String = 'Детектор4';
// Состояния измерения
  rsDosNotMeasured              : String = 'Не измерен';
  rsDosMeasErr                  : String = 'Ошибка';
  rsDosMeasWarning              : String = 'Предупреждение';
  rsDosMeasForProcessing        : String = 'Пользовательское предупреждение';
  rsDosFinished                 : String = 'Измерение завершено';
  rsDosAccepted                 : String = 'Измерен';
// Журнал действий оператора
  rsTime                        : String = 'Время';
  rsComboBox1Minute             : String = '1 минута';
  rsComboBox10Minutes           : String = '10 минут';
  rsComboBox1Hour               : String = '1 час';
  rsComboBox8Hour               : String = '8 часов';
  rsComboBox1Day                : String = '1 день';
  rsComboBox1Week               : String = '1 неделя';
  rsComboBox1Month              : String = '1 месяц';
// Фильтр
  rsFltOrg                      : String = 'Организация';
  rsFltDep                      : String = 'Подразделение';
  rsFltPart                     : String = 'Партия';
  rsFltDosType                  : String = 'Тип дозиметра';
  rsFltDosStatus                : String = 'Статус';
  rsFltPersNumber               : String = 'Табельный номер';
  rsFltIDK                      : String = 'ИДК';
  rsFltMeasTime                 : String = 'Дата измерения';
  rsFltMeasTimeFrom	        : String = 'с';
  rsFltMeasTimeTo	        : String = 'по';
  rsFltMeasStatus               : String = 'Статус измерения';
  rsFltMeasComment              : String = 'Комментарий';
// Отчет
  rsRptTitle                    : String = 'Отчет';
  rsTitleMeasTime               : String = 'Время измерения';
  rsDateLabelMemo		            : String = 'Дата формирования отчета:';
  rsRptError                    : String = 'Ошибка создания отчета';
// Для логов
  rsEnter                       : String = 'Вход в программу';
  rsExit                        : String = 'Выход из программы';
// Сообщения
  rsMsgFileAlreadyExists        : String = 'Файл с таким именем уже существует. Заменить';
  rsMsgWarning                  : String = 'Внимание';
  rsMsgFoundInvalidMeasToCalibr : String = 'Обнаружены невалидные измерения. Отправить на калибровку?';
  rsMsgNeedToUpdateDBOrClose    : String = 'В противном случае программа быдет закрыта. Выполнить обновлние базы данных?';
  rsMsgCalibrDiffParts          : String = 'Калибруемые дозиметры принадлежат разным партиям. Применить калибровку для всех дозиметров в партиях';
  rsMsgCalibrAllPart            : String = 'Калибруемые дозиметры принадлежат партии. Применить калибровку для всех дозиметров в партии';
// Выполнение измерений
  rsSmDeviceIsReady             : String = 'Установка готова к измерениям';
  rsSmNoConnection              : String = 'Нет связи';
  rsSmKSIReading                : String = 'Считывание контрольной светосуммы';
  rsSmKSILbl                    : String = 'Контрольная светосумма';
  rsSmContinueMeasuring         : String = 'Продолжить';
  rsSmNext                      : String = 'Далее';
  rsSmLoadD1                    : String = 'Загрузите детектор 1';
  rsSmLoadD2                    : String = 'Загрузите детектор 2';
  rsSmLoadD3                    : String = 'Загрузите детектор 3';
  rsSmLoadD4                    : String = 'Загрузите детектор 4';
  rsSmWaitingLoad               : String = 'Ожидание загрузки';
  rsSmNotMeasured               : String = 'Не измерен';
  rsSmLoadingDetectors          : String = 'Загрузка детекторов';
  rsSmWaitingMeas               : String = 'Ожидание измерения';
  rsSmWaitingMeasD1             : String = 'Ожидание измерения детектора 1';
  rsSmWaitingMeasD2             : String = 'Ожидание измерения детектора 2';
  rsSmWaitingMeasD3             : String = 'Ожидание измерения детектора 3';
  rsSmWaitingMeasD4             : String = 'Ожидание измерения детектора 4';
  rsSmMeasInProcess             : String = 'Идет измерение';
  rsSmStoveHeating              : String = 'Нагрев';
  rsSmStoveCooling              : String = 'Остывание';
  rsSmError                     : String = 'Ошибка';
  rsSmMeasD1                    : String = 'Измерение детектора 1';
  rsSmMeasD2                    : String = 'Измерение детектора 2';
  rsSmMeasD3                    : String = 'Измерение детектора 3';
  rsSmMeasD4                    : String = 'Измерение детектора 4';
  rsSmMeasD1Finished            : String = 'Измерение детектора 1 завершено';
  rsSmMeasD2Finished            : String = 'Измерение детектора 2 завершено';
  rsSmMeasD3Finished            : String = 'Измерение детектора 3 завершено';
  rsSmMeasD4Finished            : String = 'Измерение детектора 4 завершено';
  rsSmErrorMeasD1               : String = 'Ошибка измерения детектора 1';
  rsSmErrorMeasD2               : String = 'Ошибка измерения детектора 2';
  rsSmErrorMeasD3               : String = 'Ошибка измерения детектора 3';
  rsSmErrorMeasD4               : String = 'Ошибка измерения детектора 4';
  rsSmMeasDosStopped            : String = 'Измерение прервано';
  rsSmMeasFinished              : String = 'Измерение завершено';
  rsSmWarning                   : String = 'Программное предупреждение';
  rsSmProcessedWarning          : String = 'Обработан с замечаниями';
  rsSmProcessedError            : String = 'Ошибка обработки';
  rsSmMeasSucceed               : String = 'Измерен успешно';
  rsSmMeasAccepted              : String = 'Измерение принято';
  rsSmMeasError                 : String = 'Ошибка измерения';
  rsSmDetLost                   : String = 'Утерян';
  rsSmDetBroken                 : String = 'Сломан';
  rsSmDetSkipped                : String = 'Пропущен';
  rsSmMeasDate                  : String = 'Дата измерения';
  rsSmMeasID                    : String = '№ изм.';
  rsSmKS                        : String = 'КС';
  rsSmMeasStatus                : String = 'Статус изм.';
  rsSmRegistrationDate          : String = 'Дата регистрации';
  rsSmVerificationDate          : String = 'Дата поверки';
  rsSmCommentToMeas             : String = 'Комментарий к измерению';
  rsSmCommentToDos              : String = 'Комментарий к дозиметру';
  rsSmTLDUser                   : String = 'Пользователь ТЛД';
  rsSmTldID                     : String = '№ установки';
  rsSmMeasShort                 : String = 'Изм-й';
  rsSmLastMeasComment           : String = 'Комментарий к последнему измерению';
  rsSmLastMeasStatus            : String = 'Статус последнего измерения';
  rsSmLastMeasTime              : String = 'Дата последнего измерения';
  rsSmDosimeters                : String = 'Дозиметров';
  rsSmCalibrDose                : String = 'Доза облучения';
  rsSmDoseType                  : String = 'Тип излучения';
// Импорт дозиметров
  rsImpAddedRecord              : String = 'Добавление записи';
  rsImpUpdatedRecord            : String = 'Обновление записи';
  rsImpAddedRecords             : String = 'Добавлено записей';
  rsImpUpdatedRecords           : String = 'Обновлено записей';
  rsImpFindedErrors             : String = 'Зафиксировоно ошибок';
  rsImpErrFindingDosType        : String = 'Ошибка поиска типа дозиметра';
  rsImpErrFindingDetType        : String = 'Ошибка поиска типа детектора';
  rsImpCantFindDosType          : String = 'Не найден указанный тип дозиметра';
  rsImpCantFindDetType          : String = 'Не найден указанный тип детектора';
  rsImpAddRecordSuccess         : String = 'Добавлена запись';
  rsImpAddRecordErr             : String = 'Ошибка добавления записи';
  rsImpUpdateDosTypeSuccess     : String = 'Выполнено обновление типа дозиметра';
  rsImpUpdateDosTypeErr         : String = 'Ошибка обновления типа дозиметра';
  rsImpUpdateDetTypeSuccess     : String = 'Выполнено обновление типа детектора';
  rsImpUpdateDetTypeErr         : String = 'Ошибка обновления типа детектора';
  rsImpUpdateDos                : String = 'Выполнено обновление дозиметра';
  rsImpUpdateDosErr             : String = 'Ошибка обновления дозиметра';
  rsImpBackupTableErr           : String = 'Ошибка создания резервной копии таблицы';
  rsImpDropTableErr             : String = 'Ошибка удаления таблицы';
  rsImpDosExistErr              : String = 'Ошибка проверки наличия дозиметра';
  rsImpDosTypeExistErr          : String = 'Ошибка проверки наличия типа дозиметра';
  rsImpDetTypeExistErr          : String = 'Ошибка проверки наличия типа детектора';
  rsImpTableExistErr            : String = 'Ошибка проверки наличия таблицы';
  rsImpRanameTableErr           : String = 'Ошибка переименования таблицы';
  rsImpSQLScriptSuccess         : String = 'Выполнен SQL-скрипт';
  rsImpSQLScriptErr             : String = 'Ошибка выполнения SQL-скрипта';
  rsImpInformation              : String = 'Информация';

  rsImpDosListBuilding          : String = 'Формирование списка дозиметров';
  rsImpDosTypeListBuilding      : String = 'Формирование списка типов дозиметров';
  rsImpDetTypeListBuilding      : String = 'Формирование списка типов детекторов';
  rsImpSettingsListBuilding     : String = 'Формирование списка настроек';
  rsImpMeasListBuilding         : String = 'Формирование списка измерений';
  rsImpDosType                  : String = 'Импорт типов дозиметров';
  rsImpDetType                  : String = 'Импорт типов детекторов';
  rsImpMeas                     : String = 'Импорт измерений';
  rsImpSettings                 : String = 'Импорт настроек';
  rsImpDos                      : String = 'Импорт дозиметров';

// Единицы измернения
  rsUntmSv                      : String = 'мЗв';
  rsUntmGy                      : String = 'мГр';
// Резервное копирование БД
  rsBkErr                       : String = 'Не удалось создать резервную копию базы данных';
  rsBkSuccess                   : String = 'Резервная копия базы данных успешно создана';
  // Прочие параметры

// uDetectorConstructorForm
  rsProfileParamsEmpty          : String = 'Не заполнены параметры профиля нагрева';
  rsMethodEmpty                 : String = 'Не указан метод обработки';
  rsMatherial                   : String = 'Материал';
  rsCalcMethod                  : String = 'Метод обработки';
  rsDetectorParamsUpdated       : String = 'Обновлены параметры детектора';
  rsDeleteDetectorType          : String = 'Удалить тип дозиметра "%s" ?';
  rsErrDeleteDetectorType       : String = 'Ошибка удаления типа детектора';
  rsDetailInfoAtFile            : String = 'Подробная информация в файле';
  rsDeleteDetectorTypeDenied    : String = 'Удаление типа детектора "%s" запрещено! Тип зарегистрирован в библиотеке типов дозиметров.';
  rsTemperatureProfile          : String = 'Профиль нагрева материала %s:';
// uDosimeterConstructorForm
  rsInputCorrectKoeff           : String = 'Введите корректное значение коэффициента';
  rsInputCorrectNewDosimeterNumbers  : String = 'Введите корректный номер и количество дозиметров';
  rsDosimeterTypeRequired       : String = 'Не указан тип дозиметра';
  rsNewPartyAdded               : String = 'Добавлена новая партия "%s"';
  rsErrNewPartyAdded            : String = 'Не удалось добавить новую партию "%s"';
  rsPartyExists                 : String = 'партия уже существует';
  rsPartyReform                 : String = 'Расформировать и создать новую с таким же названием';
  rsNeedPartyName               : String = 'Укажите название партии';
  rsDosimeterUpdated            : String = 'Обновлен дозиметр';
  rsErrDosimeterUpdated         : String = 'Не удалось обновить дозиметр';
  rsDosimeterAdded              : String = 'Добавлен дозиметр';
  rsErrDosimeterAdded           : String = 'Не удалось добавить дозиметр';
  rsErrDosimeterAddOrUpdated    : String = 'Не удалось добавить/обновить дозиметр';
  rsErrBuildDosimeterList       : String = 'Не удалось сформировать список дозиметров';
// uDosimeterPartForm
  rsErrDeleteParty              : String = 'Ошибка удаления партии';
  rsPartyName                   : String = 'Название партии';
  rsParties                     : String = 'Партий';
  rsDeleteParty                 : String = 'Удалить партию "%s"?';
  rsDeletePartDosimetersExist   : String = 'В партии "%s" содержатся дозиметры (%s шт.). Удалить партию?';
  rsFoundMeasuresAfterCalibration     : String = 'Найдены измерения проведенные после указанной даты проверки';
  rsNums                              : String = 'шт.';
  rsRecalcMeasuresAfterCalibration    : String = 'Пересчитать измерения с новым коэффициентом';
  rsRecalculation                     : String = 'Перерасчет измерений';
// uDosimeterTypeConstruction
  rsTypeName                    : String = 'Название типа';
  rsErrDeleteDosimeterType      : String = 'Ошибка удаления типа дозиметра';
  rsDeleteType                  : String = 'Удаление типа';
  rsDenied                      : String = 'запрещено';
  rsNewDosimeterTypeRegistered  : String = 'Тип зарегистрирован в библиотеке измеряемых дозиметров';
// uChangePassForm
  rsChangeUserPasswordQuery     : String = 'Изменить пароль пользователя %s?';
  rsChangeUserPassword          : String = 'Изменен пароль пользователя %s';
  rsAccessRightsTemplate        : String = 'Шаблон прав доступа';
// uAddUserForm
  rsAddedUser                   : String = 'Добавлен пользователь %s';
// uMainForm
  rsSoftwareName                : String = 'DVG Установка Доза ТЛД';//'Доза ТЛД';
  rsLogStartTest                : String = 'Запуск тестирования установки';
  rsDBConnectionOK              : String = 'Подключение к базе данных "%s" - ОК';
  rsDB                          : String = 'БД';
  rsDBisNotOpen                 : String = 'БД не открыта';
  rsDBConnectionFaultShort      : String = 'Не удалось подключиться к БД';
  rsDB_ASIDK                    : String = 'БД АСИДК';
  rsDB_ASIDKConnestionOK        : String = 'Подключение к базе данных АСИДК "%s" - OK';
  rsDB_ASIDKisNotOpen           : String = 'БД АСИДК не открыта';
  rsDB_ASIDKConnectionFaultShort: String = 'Не удалось подключиться к БД АСИДК';
  rsUserRightsChanged           : String = 'Права доступа пользователя %s обновлены (%x)';
  rsChartTitle                  : String = 'Дозиметр - %s';
  rsReservedCopyName            : String = 'Название резервной копии';
  rsDBSaveFault                 : String = 'Ошибка записи данных в БД';
  rsDBFindNewRecIndex           : String = 'Ошибка поиска индекса новой записи в БД';
  rsDBConnectionError           : String = 'Ошибка подключения к БД';
  rsDB_ASIDKConnectionError     : String = 'Ошибка подключения к БД АСИДК';
  rsDBErrorFound                : String = 'Обнаружено повреждение базы данных';
  rsAuthentificationError       : String = 'Ошибка аутентификации пользователя';
  rsLogoutDeniedWhenMeas        : String = 'Запрещен выход из программы в процессе измерения';
  rsKeyExitPressed              : String = 'Нажата кнопка "Выход из программы"';
  rsPressYesWhenAgry            : String = 'Для подтверждения нажмите "Да"';
  rsBackupBackupFiles           : String = 'Файл базы данных "Доза ТЛД"|*.backup';
  rsBackupSqlFiles              : String = 'Файл базы данных "Доза ТЛД"|*.sql';
  rsBackupFiles                 : String = 'Файл базы данных "Доза ТЛД"|*.backup';
  rsDBCurrentVersion            : String = 'Текущая версия базы данных';
  rsDBUpgradeNeeded             : String = 'Необходимо обновление базы данных до версии';
  rsDBUpgradeSuccess            : String = 'База данных успешно обновлена';
  rsDBUpgradeError              : String = 'Ошибка обновления базы данных';
  rsCircling                    : String = 'Зацикливание';
  rsCheckUpgrade                : String = 'Проверьте файл обновления БД v';
  rsDBVersionNotChanged         : String = 'Номер версии базы не изменился после обновления';
  rsDBCreateReservFailure       : String = 'Ошибка создание резервной копии базы данных';
  rsProgramWillClosed           : String = 'Программа будет закрыта';
  rsDBVersion                   : String = 'Версия базы данных';
  rsDBVersionTooMatch           : String = 'База данных создана с использование более новой версии ПО';
  rsNeedUpdateSsoft             : String = 'Для работы необходимо обновить ПО';
  rsDeleteDosimetersGroup       : String = 'Удалить группу выведенных из эксплуатации дозиметров';
  rsDeleteDosimetersFailure     : String = 'Ошибка удаления выведенных из эксплуатации дозиметров';
  rsDeleteDosimetersSuccess     : String = 'Выведенные из эксплуатации дозиметры удалены';
  rsNoDosimetersForDel          : String = 'Выведенные из эксплуатации дозиметры отсутствуют';
  rsDeleteDosimeters            : String = 'Удалить группу помеченных на удаление измерений';
  rsDeleteErrorsFailure         : String = 'Ошибка удаления помеченных на удаление измерений';
  rsDeleteMeasures              : String = 'Помеченные на удаление измерения удалены';
  rsDeletedMeasuresAbsent       : String = 'Помеченные на удаление измерения отсутствуют';
  rsDeleteDBAsk                 : String = 'Удалить БД - %s?';
  rsDeleteDB                    : String = 'Удаление БД - %s';
  rsDeletedDB                   : String = 'Удалена база данных';
  rsDBDeleteFailure             : String = 'Не удалось удалить базу данных';
  rsDBDeleteOpenDenied          : String = 'Невозможно удалить открытую базу данных';
  rsPartyExclude                : String = 'Исключить дозиметр(-ы) %s из партии(-й) %s?';
  rsPartyExcludeOne             : String = 'Исключить дозиметр %s из партии %s?';
  rsDBExport                    : String = 'Экспорт базы данных';
  rsDBExportTo                  : String = 'Экспорт в БД - ';
  rsDBExportDenied              : String = 'Экспорт БД невозможен';
  rsDBExportDenied2             : String = 'Невозможен экспорт базы данных';
  rsExportDone                  : String = 'Экспорт выполнен';
  rsExportDone2                 : String = 'Выполенен экспорт базы данных';
  rsToFile                      : String = 'в файл';
  rsDBExportDeniedNoFile        : String = 'Файл не найден - %s/cЭкспорт БД невозможен!';
  rsFileNotFound                : String = 'Не найден файл';
  rsDBImport                    : String = 'Восстановление БД из - ';
  rsDBImportFromReserved        : String = 'Восстановление базы данных из резервной копии';
  rsDBImportDone                : String = 'Выполнено восстановление базы данных из резервной копии';
  rsDBImportFailure             : String = 'Ошибка восстановление базы данных из резервной копии';
  rsDBWorkChecked               : String = 'Указана рабочая база данных';
  rsDBChooseWorkForImport       : String = 'Укажите резервную копию базы данных для восстановления';
  rsMeasuring                   : String = 'Идет измерение!';
  rsTestStarted                 : String = 'Тестирование запущено';
  rsMeasurementDone             : String = 'ИЗМЕРЕНИЕ ДОЗИМЕТРА %s ЗАВЕРШЕНО';
  rsHardResetFound              : String = 'Обнаружен признак перезагрузки установки';
  rsSaveTemperatures            : String = 'Запись термопрофиля';
  rsSrcData                     : String = 'Первичные данные';
  rsGot                         : String = 'получены';
  rsSaveToDB                    : String = 'сохранены в БД';
  rsData                        : String = 'Данные';
  rsCalculated                  : String = 'обработаны расчетным модулем';
  rsShowed                      : String = 'обработаны ShowCalcFunctions';
  rsLostConnectionWhenMeasure   : String = 'Потеря связи при измерении';
  rsDosimetersGroupToOut        : String = 'Вывести из эксплуатации группу дозиметров';
  rsDosimeterOut                : String = 'Выведен из эксплуатации дозиметр';
  rsDosimeterOutFailure         : String = 'Не удалось вывести из эксплуатации дозиметр';
  rsNotChooseDosimeterOut       : String = 'Не выбран дозиметр для вывода из эксплуатации';
  rsDeleteMeasuresGroupAsk      : String = 'Удалить группу из %d измерений?';
  rsDeleteMeasureFailure        : String = 'Ошибка удаления измерения';
  rsOfDosimeter                 : String = 'дозиметра';
  rsDeleteMeasureAsk            : String = 'Удалить измерение № %s дозиметра %s?';
  rsNotChooseMeasureToDel       : String = 'Не выбрано измерение для удаления';
  rsNotChooseMeasure            : String = 'Не выбрано измерение';
  rsDeleteUserAsk               : String = 'Удалить пользователя %s?';
  rsUserDeleted                 : String = 'Удален пользователь %s';
  rsSaveChanges4MeasGroup       : String = 'Сохранить изменения для группы измерений';
  rsNotBind                     : String = 'Не привязан';
  rsBind                        : String = 'Привязан';
  rsLoadingFilters              : String = 'Загрузка фильтров';
  rsLoadingPageDosimeters       : String = 'Загрузка страницы дозиметров';
  rsLoadingPageEdit             : String = 'Загрузка страницы обработки';
  rsLoadingPageMeasuring        : String = 'Загрузка страницы измерений';
  rsLoadingPageCalibration      : String = 'Загрузка страницы калибровки';
  rsApplicationStartedEarlier   : String = 'Приложение уже запущено';
  rsCRCFailure                  : String = 'Ошибка CRC блока данных';
  rsFilterSet                   : String = 'Установлен фильтр K = %s';
  rsMotorFailure                : String = 'Ошибка шагового двигателя';
  rsHeaterFailure               : String = 'Ошибка в работе печки';
  rsConnectionFailure           : String = 'Ошибка связи по RS-485';
  rsPanelConnectionFailure      : String = 'Ошибка связи с панелью';
  rsBigDose                     : String = 'Большая доза';
  rsCRCError                    : String = 'Ошибка контрольной суммы';
  rsPort                        : String = 'Порт';
  rsReInited                    : String = 'переинициализирован';
  rsReInitFailure               : String = 'Не удалось переинициализировать порт';
  rsDifferentDosimeterTypes     : String = 'Выбраны дозиметры разных типов';
  rsDifDosimeterTypesDetail     : String = 'Групповое присвоение коэффициенов возможно только для дозиметров одного типа';
  rsCreateDidntWork             : String = 'Не отработал конструктор Create';
  rsDosimeterRecalc             : String = 'Пересчитана доза в дозиметре';
  rsNotDefined                  : String = 'Не определено';
  rsProcessing                  : String = 'Обработка';
  rsConfirmSelfPermit           : String = 'Вы уверены, что хотите ограничить право для самого себя';
  rsStopBeforeStart             : String = 'Запущен процесс %s \nПеред запуском нового процесса остановите предыдущий';
  //  uMyComPort
  rsGetCOMPortFailure           : String = 'Не удалось получить данные порта';
  rsGetTimeOutsFailure          : String = 'Не удалось получить значения тайм-аутов';
  rsSetTimeOutsFailure          : String = 'Не удалось установить тайм-ауты';
  rsGetDataComPortFailure       : String = 'Ошибка чтения данных из порта';
  rsSendComPortFailure          : String = 'Не удалось послать данные';
  // uSetConnection
  rsErrStartPos0                : String = 'aStartPos должен быть больше 0';
  // uTLDCommand
  rsErrSetRate                  : String = 'Не удалось установить скорость';
  rsErrCalcModBusCRC            : String = 'Ошибка подсчета ModBusCRC';
  rsEmulatorAnswer              : String = 'Эмулятор - ответ';
  rsConnectionIsOn              : String = 'Связь с прибором установлена';
  rsEmulationIsOn               : String = 'Запущен режим эмуляции';
  rsNoAnswer                    : String = 'Нет ответа';
  rsPortConnection              : String = 'Соединение с портом';
  rsReturned                    : String = 'восстановлено';
  rsLost                       : String = 'потеряно';
  rsRecall                      : String = 'повторный запрос (из-за ошибки CRC)';
  rsErrCommand                  : String = 'Ошибка при выполнении команды';
  rsCommandDone                 : String = 'Команда выполнена';
  rsCommandDoing                : String = 'Команда выполняется';
  rsCommandOverlay              : String = 'Наложение команд';
  rsCommandNoExecutable         : String = 'Команда невыполнима';
  rsCommandBreakByUser          : String = 'Команда прервана пользователем';
  rsSendWaitTimeout             : String = 'Порт не освободился для отправки команды (таймаут ожидания предыдущей передачи)';
  rsAnswerTrace                 : String = 'Получен ответ устройства: состояние=%d, байт=%d';
  rsTimeOutMotor1               : String = 'Таймаут ШД1(стол)';
  rsTimeOutMotor2               : String = 'Таймаут ШД2(печка)';
  rsJamming                     : String = 'Заклинивание стола (таймаут ШД1(стол))';
  rsJammingDetail               : String = 'Возможные неисправности:\n - попадание детектора между столом и корпусом;\n - прилипание чашки к кварцевому стеклу.';
  rsOffsetMotor1                : String = 'Смещение вала ШД1(стол)';
  rsOffsetMotor2                : String = 'Смещение вала ШД2(печка)';
  rsNeedRepair                  : String = 'Требуется ремонт';
  rsGapNotFound1                : String = 'Щель ШД1(стол) не найдена';
  rsGapNotFound2                : String = 'Щель ШД2(печка) не найдена';
  rsWeekSignal1                 : String = 'Слабый сигнал оптопары %s ШД1(стол)';
  rsWeekSignal2                 : String = 'Слабый сигнал оптопары %s ШД2(печка)';
  rsErrESPPZU                   : String = 'Ошибка ЭСППЗУ';
  rsHeatTooMatch                : String = 'Недопустимое время нагрева печки 1';
  rsFalseParameter1             : String = 'Неверный параметр отклонения от термопрофиля печки 1';
  rsErrHeaterCRC                : String = 'Ошибка КС печки 1';
  rsFalseParameter2             : String = 'Недопустимое отклонение от термопрофиля печки 1';
  rsHeaterTPBreak               : String = 'Обрыв термопары печки 1';
  rsTooHiTempWhenStart          : String = 'Высокая начальная температура печки 1';
  rsMechError                   : String = 'Ошибка механики';
  rsMechErrorDetail             : String = 'Недопустимое положение стола для проведения измерений.\nВозможные неисправности:\n - заклинивание стола.';
  rsCoinsidenceCRC              : String = 'Совпадение CRC: CRC TLD %s = CRC ПО %s';
  rsErrCoinsidenceCRC           : String = 'CRC TLD %s <> CRC ПО %s !!!';
  rsErrCRC                      : String = 'Ошибка CRC';
  rsErrCRCDetail                : String = 'Контрольная сумма результатов измерений установки не совпадает с контрольной суммой рассчитанной программой.';
  rsMeasurementStopped          : String = 'Измерение остановлено';
  rsErrPlaceNotFound            : String = 'Положение не определено';
  rsCommandReset                : String = 'Команда: Сброс';
  rsPlaceControl                : String = 'Положение КСИ';
  rsLoadD1                      : String = 'Загрузка Д1';
  rsLoadD2                      : String = 'Загрузка Д2';
  rsLoadD3                      : String = 'Загрузка Д3';
  rsLoadD4                      : String = 'Загрузка Д4';
  rsMeasurementD1               : String = 'Измерение Д1';
  rsMeasurementD2               : String = 'Измерение Д2';
  rsMeasurementD3               : String = 'Измерение Д3';
  rsMeasurementD4               : String = 'Измерение Д4';
  rsHeaterUp                    : String = 'Печка вверх';
  rsHeaterDown                  : String = 'Печка вниз';
  rsReadCSS                     : String = 'Считать КСИ';
  rsReadTempProfile             : String = 'Считать термопрофиль';
  rsSaveTempProfile             : String = 'Запись температурного профиля';
  rsStartMeasurement            : String = 'Начать измерение';
  rsStopMeasurement             : String = 'Остановить измерение';
  rsReadMeasurement             : String = 'Считать измерения';
  rsReadPlace                   : String = 'Считывание позиции стола';
  rsReadDeviceInfo              : String = 'Считывание описания установки';
  rsSaveDeviceNumber            : String = 'Запись номера установки';
  rsSaveDeviceHWVersion         : String = 'Запись конструктива установки';
  rsSaveEEPROM                  : String = 'Запись в EEPROM';
  rsCommonRepeat                : String = '   - нет ответа, повторный запрос';
  rsMotorsReadDeviceNumber      : String = ' Motors: Чтение номера установки';
  rsMotorsSetPosition           : String = ' Motors: Позиционирование ШД%D в позицию %D';
  rsMotorsReadProgress          : String = ' Motors:   - ШД%D ожидание выполнения';
  rsMotorsStop                  : String = ' Motors: Аварийная остановка ШД%D';
  rsMotorsInit                  : String = ' Motors: Инициализация (253) ШД%D';
  rsMotorsInit1_252             : String = ' Motors: Инициализация (252) ШД1';
  rsMotorsInit1_251             : String = ' Motors: Инициализация (251) ШД1';
  rsMotorsReadBase              : String = ' Motors: Чтение базовых параметров';
  rsMotorsReadRWParams1         : String = ' Motors: Чтение RW параметров 1';
  rsMotorsReadRWParams2         : String = ' Motors: Чтение RW параметров 2';
  rsMotorsPowerLine1On          : String = ' Motors: Включить линию питания 1';
  rsMotorsPowerLine2On          : String = ' Motors: Включить линию питания 2';
  rsMotorsPowerLine1Off         : String = ' Motors: Выключить линию питания 1';
  rsMotorsPowerLine2Off         : String = ' Motors: Выключить линию питания 2';
  rsMotorsPowerLine3On          : String = ' Motors: Включить линию питания 3';
  rsMotorsPowerLine3Off         : String = ' Motors: Выключить линию питания 3';
  rsMotorsWriteDigitalOutput    : String = ' Motors: Запись значений выходов';
  rsMotorsWriteParams4One       : String = ' Motors: Запись параметров для ШД%D';
  rsMotorsWriteEEPROM           : String = ' Motors: Запись параметров в EEPROM';
  rsMotorsWriteStatParams       : String = ' Motors: Запись статистических параметров';
  rsMotorCommandDone            : String = ' Motors: Команда выполнена';
  rsMotorCommandDoneWErr        : String = ' Motors: Команда выполнена с ошибкой';
  rsAirHeatReadAll              : String = ' AirHeat: Чтение параметров';
  rsAirHeatReadHolding          : String = ' AirHeat: Чтение параметров нагрева';
  rsAirHeatReadInput            : String = ' AirHeat: Чтение температур и потоков';
  rsAirHeatWriteProfile         : String = ' AirHeat: Запись термопрофиля %s';
  rsAirHeatWriteBurnProfile     : String = ' AirHeat: Запись термопрофиля отжига';
  rsAirHeatWriteStatus          : String = ' AirHeat: Запись статуса %d';
  rsAirHeatA1                   : String = ' AirHeat: Чтение параметров (A1)';
  rsAirHeatA2                   : String = ' AirHeat: Старт нагрева (A2)';
  rsAirHeatA3                   : String = ' AirHeat: Остановка нагрева (A3)';
  rsAirHeatA5_inKTV             : String = ' AirHeat: Чтение параметров (A5_inKTV)';
  rsAirHeatReadedTemp           : String = ' AirHeat: Текущие температуры: T1=%g:.1 T2=%g:.1';
  rsAirHeatA6                   : String = ' AirHeat:   - ожидание остывания (T1=%g, T2=%g) до %d';
  rsMonitorReadAll              : String = ' Monitor: Чтение параметров';
  rsMonitorWriteAll             : String = ' Monitor: Запись параметров';
  rsMonitorInit                 : String = ' Monitor: Инициализация';
  rsMonitorM1                   : String = ' Monitor: Чтение параметров (M1)';
  rsMonitorM2                   : String = ' Monitor: Выключение (M2)';
  rsMonitorM3                   : String = ' Monitor: Включение (M3)';
  rsMonitorM4                   : String = ' PMTNew: Инициализация элемента Пельте (M4) - %g';
  rsPMTReadAll                  : String = ' PMT: Чтение параметров';
  rsPMTWriteAll                 : String = ' PMT: Запись параметров';
  rsPMTP1                       : String = ' PMT: Чтение параметров (P1)';
  rsPMTReadBase                 : String = ' PMT: Чтение базовых параметров и КТВ';
  rsPMTReadNumChan              : String = ' PMT: Чтение числа прочитанных регистров';
  rsPMTReadKTV                  : String = ' PMT: Чтение КТВ';
  rsPMTStart                    : String = ' PMT: Старт';
  rsPMTSetTime                  : String = ' PMT: Установка времени измерения (%d сек.) и старт';
  rsPMTWaitDone                 : String = ' PMT:   - Ожидание выполнения';
  rsPMTNewSleep                 : String = ' PMTNew: Засыпаем на %d мс чтобы синхронизировать процессы в платах AirHeat и PMT';
  rsPMTNewReatKTV               : String = '   КТВ Считано %d  (NUM_CH1=%d) из 300';
  rsPMTNewSwitch1               : String = ' PMTNew: Установка LED_1 - %d';
  rsPMTNewSwitch2               : String = ' PMTNew: Установка LED_2 - %d';
  rsPMTNewSwitch3               : String = ' PMTNew: Установка Элемент Пельтье - %d';
  rsPMTNewDarkCurStart          : String = ' PMTNew: Запуск измерения темнового тока';
  rsPMTNewSrcCurStart           : String = ' PMTNew: Запуск измерения тока от контрольного источника';
  rsPMTNewSetTargetTemperature  : String = ' PMTNew: Установка целевой температуры для элемента Пельтье (%g)';
  rsPMTNewSetControlTime        : String = ' PMTNew: Установка времени контроля темнового тока и тока от источника (%d)';
  rsPMTNewSetDevNumber          : String = ' PMTNew: Установка номера установки (%d)';
  rsPMTNewGetDevNumber          : String = ' PMTNew: Чтение номера установки';
  rsScanStartRead               : String = ' Scaner: Старт чтения штрихкода';
  rsScanReadBase                : String = ' Scaner: Чтение базовых данных штрихкода';
  rsScanReadBarCode             : String = ' Scaner: Чтение штрихкода';
  rsUserPanelCommand            : String = ' UserPanel: Команда из панели %s';
  rsScanFailed                  : String = ' Scaner: Сканирование не удалось';
  rsCommonCheckBeforeSwapping   : String = 'Check: Проверка перед сменой кассет';
  rsBadCheckBeforeSwapping      : String = 'Check: Кассетницы не подняты - выполнение остановлено';
  rsCommonCheckCassA_Down       : String = 'Check: Проверка опущенности и наличия кассетницы А';
  rsCommonCheckCassB_Down       : String = 'Check: Проверка опущенности и наличия кассетницы Б';
  rsCommonCheckCassAB_Up        : String = 'Check: Проверка поднятости кассетниц А и Б';
  rsCommonBadCheckCassA_Down    : String = 'Check: Нет кассетницы А - выполнение остановлено';
  rsCommonBadCheckCassB_Down    : String = 'Check: Нет кассетницы Б - выполнение остановлено';
  rsCommonBadCassAB_Up          : String = 'Check: Не поднялась одна из кассетниц - выполнение остановлено';
  rsCommonCheckDarkCurrent      : String = 'Check: Проверка темнового тока RLC1=%g RLC2=%g';
  rsCommonBadDarkCurrent        : String = 'Check: Темновой ток вне допустимого диапазона';
  rsCommonCheckCICurrent        : String = 'Check: Проверка тока от контрольного источника RLC1=%g RLC2=%g';
  rsCommonBadCICurrent          : String = 'Check: Ток от контрольного источника вне допустимого диапазона';
  rsCommonChooseMode            : String = 'Check Input: Выбор алгоритма';
  rsCommonCheckScan             : String = 'Check: Проверка штрихкода: %s';
  rsReturnIfMeasure             : String = 'Check: T1=%g, IC1=%d, T2=%g, IC2=%d';
  rsCommonCheckEndMeasure       : String = 'Check: Проверка на окончание измерения';
  rsCommonCallBurning           : String = 'Check: Проверка на необходимость отжига';
  rsCommonBurningOn             : String = 'Переход в РЕЖИМ ОТЖИГА';
  rsNoCheckScan                 : String = 'Штрихкод не считан';
  rsCheckScan                   : String = 'Штрихкод считан %s';
  rsDisableScanerUseManual      : String = 'Сканер отключен, используется введёный идентификатор: %s';
  rsCommonGoInit                : String = 'Переход к первичной инициализации';
  rsCommonGoIdle                : String = 'Переход в РЕЖИМ ОЖИДАНИЯ';
  rsTargetPMTTempFailure        : String = 'Установленная в Пельтье температура %g не соответствует заданной %g';
  rsFailureMotorsCommon         : String = 'Ошибка %d в плате управления шаговыми двигателями';
  rsMotorsInitRequired          : String = 'Плата управления шаговыми двигателями будет проинициализирована';
  rsMotorsGo4Required           : String = 'Позиция каретки шагового двигателя 1 будет скорректирована';
  rsCheckFiltrFailure           : String = 'Не установлен фильтродерджатель';
  rsCommonGoMotorsInit          : String = 'Инициализация двигателей';
  rsCommonCheckMotorsInit       : String = 'Проверка на необходимость инициализации двигателей';
  rsCommonCheckMotor2           : String = 'Проверка состояния ШД2 на положение Верх';
  rsCommonCheckMotor3           : String = 'Проверка состояния ШД3 на положение Верх';
  rsCommonCheckScan4Empty       : String = 'Проверка состояния сканера на отсутствие дозиметра, иначе сброс дозиметра';
  rsCommonCheckAir              : String = 'Проверка потока воздуха';
  rsCommonCall                  : String = 'Вызов подпрограммы %s из режима %s на шаге %d';
  rsCommonReturn                : String = 'Возврат из режима %d в %d на шаг %d';
  rsCasseteMotRecognized        : String = 'Штрихкод не известен';
  rsCasseteFound                : String = 'Кассета опознана - продолжаем измерение';
  rsCommonGoPushOut             : String = 'Переход в РЕЖИМ СТАЛКИВАНИЯ КАССЕТЫ';
  rsCommonGoSwapping            : String = 'Переход в РЕЖИМ СМЕНЫ КАССЕТ';
  rsCommonCallMotorsToStart     : String = 'Подпрограмма установки базового состояния ШД';
  rsCommonGoMeasuring           : String = 'Переход в РЕЖИМ ИЗМЕРЕНИЯ';
  rsCommonCallCheckAir          : String = 'Подпрограмма проверки потока воздуха';
  rsGetMeasureDone              : String = 'Режим чтения измерения из ФЭУ закончен по времени';
  rsCommonCheckEndTime          : String = 'Проверка окончания времени (%d из %d)';
  rsDelay5                      : String = 'Ожидание 5 секунд';
  rsFirstTimeStarted            : String = 'Обнаружен первый запуск программы (по непроинициализированным шаговым двигателям)';
  rsWaitTimeDone                : String = 'Время вышло';
  rsCommonCallDelay             : String = 'Подпрограмма ожидания';
  rsInternalError               : String = 'Внутренняя ошибка: %s';
  rsCommonCheckUserAnswer       : String = 'Запрос реакции пользователя';
  rsCommonUITitle               : String = 'Информационное сообщение';
  rsCommonUICheckEnd            : String = 'Кассет больше нет, процесс "%s" завершен.';
  rsCommonUIStopByUser          : String = 'Процесс %s остановлен пользователем';
  rsCommonUserAnswerOk          : String = 'Пользователь ответил "OK"';
  rsCommonUserAnswerRetry       : String = 'Пользователь ответил "Повторить"';
  rsCommonUserAnswerCancel      : String = 'Пользователь ответил "Отменить"';
  rsCommonUserAnswerAbort       : String = 'Пользователь ответил "Прервать"';
  rsCommonUserAutoAnswered      : String = 'Выход из диалога по тайм-ауту';
  rsCommonUserPanelAnswered     : String = 'Ответ получен из панели';
  rsCommonMotorsStarted         : String = 'Установка шаговых двигателей в базовое состояние выполнена';
  rsMotorsFailure               : String = 'Ошибка позизионирования шаговых двигателей';
  rsCommonNoDosimeter           : String = 'В каретке нет дозиметра для измерения';
  rsCommonBadScan               : String = 'Сканирование не удалось';
  rsAccLowFlow                  : String = 'СБОЙ: СЛИШКОМ МАЛЕНЬКИЙ ПОТОК ВОЗДУХА ОТ НАГРЕВАТЕЛЯ';
  rsAccUnknown                  : String = 'СБОЙ: ПРИЧИНЫ ТРЕБУЮТ УТОЧНЕНИЯ';
  rsMotorsBoardConFail          : String = 'ПОТЕРЯ СВЯЗИ: Плата управления шаговыми двигателями';
  rsAirHeatBoardConFail         : String = 'ПОТЕРЯ СВЯЗИ: Плата управления нагревателем';
  rsMonitorBoardConFail         : String = 'ПОТЕРЯ СВЯЗИ: Плата - монитор';
  rsPMTBoardConFail             : String = 'ПОТЕРЯ СВЯЗИ: Плата управления ФЭУ';
  rsScanBoardConFail            : String = 'ПОТЕРЯ СВЯЗИ: Сканер штрихкодов';
  rsPMTNewConFail               : String = 'ПОТЕРЯ СВЯЗИ: Новая плата чтения ФЭУ';
  rscStartSingleMeas            : String = 'Измерение';
  rscStartSeriaMeas             : String = 'Измерение серии';
  rscStartCalibration           : String = 'Калибровка';
  rscTesting                    : String = 'Тестирование';
  rscBurning                    : String = 'Отжиг';
  rscIrradiation                : String = 'Облучение';
  rscGrading                    : String = 'Разбраковка';
  rscRegistration               : String = 'Регистрация';
  rsUnknownProcess              : String = 'Неопознанный';
  rsInit                        : String = 'Инициализация';
  rsIdle                        : String = 'Ожидание';

  // uControl
  rsToSaveTempProfile           : String = 'Записать термопрофиль';
  rsFileWritten                 : String = 'Данные записаны в файл: %s';
  // uStartMF
  rsInputDosimeterNumber        : String = 'Введите номер дозиметра';
  rsDosNumMustStartCiph         : String = 'Номер дозиметра должен начинаться с цифры';
  rsImageNotFound               : String = 'Не найден файл изображения - "%s"';
  rsAddedDosimeter              : String = 'Добавлен дозиметр - ';
  rsErrAddedDosimeter           : String = 'Не удалось добавить дозиметр - ';
  rsDosimeterNotFound           : String = 'Дозиметра нет в списке\n\nДля добавления укажите тип';
  rsGiveDosimeterType           : String = 'Укажите тип дозиметра';
  rsGiveDose                    : String = 'Укажите дозу облучения!';
  rsGiveDosimeterNumber         : String = 'Введите номер дозиметра';
  rsDosimeterNotInList          : String = 'Дозиметра нет в списке';
  rsCheckFilter                 : String = 'Убедитесь, что установлен фильтр на ФЭУ';
  rsBack                        : String = 'Назад';
  rsIncorrectValue              : String = 'Значение указано не корректно!';
  rsStartNewMeasurement         : String = 'Начало нового измерения';
  rsGiveDosimeterNumber2        : String = 'Укажите номер дозиметра';
  rsClose                       : String = 'Закрыть';
  rsSkipDetector                : String = 'Пропуск детектора';
  rsSkipDetectorWhy             : String = 'Укажите причину пропуска детектора';
  rsSkipD1                      : String = 'Пропуск Д1';
  rsSkipD2                      : String = 'Пропуск Д2';
  rsSkipD3                      : String = 'Пропуск Д3';
  rsSkipD4                      : String = 'Пропуск Д4';
  rsMeasSerieEnd                : String = 'Измерение серии завершено!';
  rsCalibrationPrepare          : String = 'Подготовка к началу калибровки';
  // uDataModule
  rsDosimetersDeleted           : String = 'Удалены выведенные из эксплуатации дозиметры';
  rsNoDeletedDosimeters         : String = 'Нет выведенных из эксплуатации дозиметров для удаления';
  rsErrDeleteDosimeters         : String = 'Не удалось удалить выведенные из эксплуатации дозиметры';
  rsErrCreateDBReserved         : String = 'Не удалось создать резервную копию БД';
  rsErrDBConnection             : String = 'Нет связи с БД';
  rsPartyDeleted                : String = 'Удалена партия';
  rsErrPartyDeleted             : String = 'Не удалось удалить партию';
  rsDosTypeDeleted              : String = 'Удален тип дозиметра';
  rsErrDosTypeDeleted           : String = 'Не удалось удалить тип дозиметра';
  rsDetTypeDeleted              : String = 'Удален тип детектора';
  rsErrDetTypeDeleted           : String = 'Не удалось удалить тип детектора';
  rsMeasuresDeleted             : String = 'Удалены помеченные на удаление измерения';
  rsMeasures4DelAbcent          : String = 'Помеченные на удаление измерения отсутствуют';
  rsMeasures4DelNotDeleted      : String = 'Не удалось удалить помеченные на удаление измерения';
  rsErrDosimeterExcludeParty    : String = 'Ошибка исключения дозиметра из партии';
  rsMeasChecked4Del             : String = 'Помечено на удаление измерение';
  rsErrMeasChecked4Del          : String = 'Не удалось пометить на удаление измерение';
  rsNewDetTypeAdded             : String = 'Добавлен новый тип детектора "%s"';
  rsErrNewDetTypeAdded          : String = 'Не удалось добавить новый тип детектора "%s". %s';
  rsErrNewPartyAdded2           : String = 'Не удалось добавить новую партию "%s". %s';
  rsNewDosTypeAdded             : String = 'Добавлен новый тип дозиметра "%s"';
  rsErrNewDosTypeAdded          : String = 'Не удалось добавить новый тип дозиметра "%s". %s';
  rsDosimeter4Testing           : String = 'Дозиметр для тестирования механики';
  rsNoTable                     : String = 'Отсутствует таблица';
  rsErrCheckTable               : String = 'Ошибка проверки наличия таблицы';
  rsErrFormPartyName            : String = 'Ошибка формирования названия партии по умолчанию';
  rsErrGetDetDose               : String = 'Ошибка получения дозы детектора - %s';
  rsErrFindDetType              : String = 'Ошибка поиска типа детектора - %s';
  rsMeasurement                 : String = 'Измерение';
  rsErrFindParty                : String = 'Ошибка поиска партии - %s';
  rsErrCalcDosimetersAtParty    : String = 'Ошибка подсчета дозиметров в партии';
  rsErrDefDosTypeAtParty        : String = 'Ошибка определения типа дозиметра в партии';
  rsErrFindDosType              : String = 'Ошибка поиска типа дозиметра - %s';
  rsErrFindFormulaID            : String = 'Ошибка поиска ID формулы типа дозиметра';
  rsErrFindIDDosType            : String = 'Ошибка поиска ID типа дозиметра';
  rsDBbyFileRefresh             : String = 'Обновление базы данных из файла';
  rsErrDBbyFileRefresh          : String = 'Ошибка обновление базы данных из файла';
  rsErrDBRefresh                : String = 'Ошибка обновление базы данных';
  rsRefreshFileNotFound         : String = 'Не найден файл обновления';
  rsDBCopyDone                  : String = 'Выполнено копирование базы данных "%s" в "%s"';
  rsErrDBCopy                   : String = 'Ошибка копирования базы данных "%s" в "%s"';
  rsDBRenameDone                : String = 'Выполнено переименование базы данных "%s" в "%s"';
  rsErrFindDBComment            : String = 'Ошибка поиска комментария к БД';
  rsErrChangeDosNumberInMeas    : String = 'Ошибка изменения номера дозиметра';
  rsDBUpdate                    : String = 'Обновление БД';
// uOpenDB
  rsErrDBImport                 : String = 'Импорт БД невозможен';
  rsImportDone                  : String = 'Импорт выполнен';
  rsImportConfigDone            : String = 'Импорт настроек выполнен';
  rsFileNotFound2               : String = 'Файл не найден';
  rsDBCreated                   : String = 'База данных %s - успешно создана';
  rsErrDBCreated                : String = 'Неудалось создать базу данных - %s';
  rsErrDBExists                 : String = 'БД с указанныи именем уже существует';
  rsDataBase                    : String = 'База данных';
  rsDeleteDone                  : String = 'успешно удалена';
  rsErrDeleteDB                 : String = 'Не удалось удалить базу данных';
  rsExportImpossible            : String = 'Экспорт БД невозможен';
// uEnterDBName
  rsEnterCorrectValue           : String = 'Введите корректное значение';
  rsIllegalChar                 : String = 'Недопустимый символ';
  rsInputName                   : String = 'Введите имя';
  rsErrNameCiphFirst            : String = 'Имя не должно начинаться с цифры';
  // uLogPassForm
  rsEnterUser                   : String = 'Вход под пользователем %s';
  rsErrUserListEmpty            : String = 'Таблица пользователей пуста';
  // uImportDosimeter
  rsDosimeterRefreshed          : String = 'Обновлен дозиметр';
  rsErrDosimeterRefreshed       : String = 'Не удалось обновить дозиметр';
  rsErrAddOrRefrDos             : String = 'Не удалось добавить/обновить дозиметр';
  rsErrAddOrRefrDosType         : String = 'Не удалось добавить/обновить тип дозиметра';
  rsErrAddOrRefrDetType         : String = 'Не удалось добавить/обновить тип детектора';
  rsErrAddOrRefrSettings        : String = 'Не удалось добавить/обновить настройки';
  rsErrAddMeas                  : String = 'Не удалось добавить измерение';
  rsErrDosType                  : String = 'Не существует указанный тип';
  rsErrExportDos                : String = 'Ошибка экспорта';
  rsErrImportFile               : String = 'Ошибка структуры файла';
  // uModel
  rsErrSave                     : String = 'Ошибка сохранения';
  // uCalibrationForm
  rsFoundLateMeasures           : String = 'Найдены измерения проведенные после указанной даты проверки';
  rsReCalcWNewCoeff             : String = 'Пересчитать измерения с новым коэффициентом';
  rsNewPartyAdded2              : String = 'Добавлена новая партия';
  rsCoeffsChanged               : String = 'Изменены коэффициенты дозиметра';
  rsErrCoeffChanged             : String = 'Не удалось изменить коэффициенты дозиметра';
  // uDosimeterForm
  rsDoseIncorrect               : String = 'Доза указана не корректно!';
  // uImportDBForm
  rsCreateDB                    : String = 'Создание БД';
  rsErrDBImport3                : String = 'Не удалось выполнить импорт БД';
  rsErrDBConfigImport           : String = 'Не удалось выполнить импорт настроек';
  rsDBAlreadyExists             : String = 'БД с указанныи именем уже существует';
  rsImportDB                    : String = 'Импорт БД';
  // uReport
  rsNumber                      : String = 'Номер';
  rsType                        : String = 'Тип';
  rsAllMeasures                 : String = 'Всего измерений';
  rsRptReportReady              : String = 'Отчет сформирован';
  rsRptReportBuildig            : String = 'Формирование отчета';
  rsRptRecordValuesExceeded     : String = 'Превышено допустимое количество записей для постоения отчета';
  rsRptMaximumValue             : String = 'Максимальное значение';
  rsRptntNoSelectedRecords      : String = 'Нет выбранных записей для построения отчета';
  // uImportInCurrentDBForm
  rsImportDB2                   : String = 'Импорт базы данных';
  rsErrDBImport2                : String = 'Невозможен импорт базы данных';
  rsDBImportDone2               : String = 'Выполнен импорт базы данных из файла';
  rsDBFileImportDone            : String = 'Импорт базы данных из файла';
  rsErrDBFileImport             : String = 'Не удалось выполнить импорт базы данных из файла';
  rsError                       : String = 'Ошибка';
  rsErrDBName                   : String = 'Некорректное название БД';
  rsErrDBName2                  : String = 'Некорректное название базы данных';
  rsErrDifferentKInPart         : String = 'Попытка объединения в партию дозиметров с разными коэффициентами';
  rsErrDifferentTypeInPart      : String = 'Попытка объединения в партию дозиметров разных типов';
  rsErrDosWillNotBeAdded        : String = 'Дозиметр "%s" не будет добавлен в партию "%s"';
  // uSQLFilterForm
  rsDoneSucc                    : String = 'Выполнено успешно';
  rsErrDid                      : String = 'Ошибка выполнения';
  rsFilter                      : String = 'Фильтр';
  // uAddDosinQueue
  rsDosimeterAlreadyExists      : String = 'Дозиметр уже есть в списке';
  rsErrAddDosNum                : String = 'Дозиметр с таким номером не добавлен';
  // uQueeueForm
  rsQueueMeasures               : String = 'Очередь измерений';
  rsAllCount                    : String = 'всего';
  rsMeasID                      : String = 'ID измерения';
  rsErrNewDosTypeAdded2         : String = 'Не удалось добавить новый тип дозиметра';
  rsTypeNameExists              : String = 'Название типа уже существует';
  rsSetTypeName                 : String = 'Укажите название типа';
  rsErrNewDetTypeAdded2         : String = 'Не удалось добавить новый тип детектора';
  rsDosNumDidntSet              : String = 'Номер дозиметра не указан';
  rsStateReset                  : String = 'Сброс состояния';
  // uSendToCalibrForm
  rsRadTypeGamma                : String = 'Гамма';
  rsRadTypeNeutron              : String = 'Нейтрон';
  // uStartIrradiation
  rsIrradiationTime             : String = 'Ожидаемое время облучения %.2g мин.';
  rsIrradiationEDR              : String = 'Мощность встроенного источника %.2g мЗв/мин';

const
  SECT_Res        = 'Strings';
  SECT_Translator = 'Translator';
  SECT_Forms      = 'Forms';

type
  TLangIniFile = class(TMemIniFile)
  public
    destructor Destroy; override;
  end;

procedure TranslateComponent(Preambula: String; aComponent: TComponent); // Перевод любого компонета или формы и их вложений. Необходимо вызывать в неавтокриэйтных формах при Create для форм
procedure AllActiveFormsTranslate; // Перевод всего активного. Запускать после создания форм, но до запуска программы
//procedure SaveFormImage(aForm: TForm; aDir,aName: String); // формирование скриншота

procedure ReadLangIniString(SECT: String; aValName: String; var aDef: String); // чтение отдельных строк

implementation
uses
  SysUtils, StdCtrls, Rtti, StrUtils, uMainForm, Dialogs, TypInfo, SlavaTools, Graphics;
// Imaging.jpeg,

var
  LangIniFile: TLangIniFile;


destructor TLangIniFile.Destroy;
begin
  inherited Destroy;
end;

function SetIniString(aVal: String):String;
begin
  result := StringReplace(aVal,sLineBreak,'\n',[rfReplaceAll]);
  result := StringReplace(result,'=','\e',[rfReplaceAll]);
  if result='' then Exit;
  if result[1]='_' then result := '\'+result;
  if result[1]=' ' then result[1]:='_';
  if result[length(result)]='_' then begin result[length(result)]:='\'; result := result + '_'; end;
  if result[length(result)]=' ' then result[length(result)]:='_';
end;

function GetIniString(aVal: String):String;
begin
  if aVal='' then Exit;
  if pos('\n',aVal)>0 then
  begin
    result := result + '';
  end;
  result:=StringReplace(aVal,'\n',sLineBreak,[rfReplaceAll]);
  if result[1]='_' then result[1]:=' ';
  if result[length(result)]='_' then result[length(result)]:=' ';
  result:=StringReplace(result,'\e','=',[rfReplaceAll]);
  result:=StringReplace(result,'\_','_',[rfReplaceAll]);
end;

function IsRussian(aSt: String):boolean;
const
 RusTable: String = 'ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮёйцукенгшщзхъфывапролджэячсмитьбю';
var
 i: integer;
begin
 Result := False;
 for i:=1 to Length(aSt) do
   if Pos(aSt[i], RusTable) <> 0 then
     Result := True;
end;

procedure ReadLangIniString(SECT: String; aValName: String; var aDef: String);
var
  aVal: String;
begin
//  if not Assigned(LangIniFile) then InitLanguage;
  if not Assigned(LangIniFile) then Exit;

  if LangIniFile.ValueExists(SECT,aValName)
  then aDef := GetIniString(LangIniFile.ReadString(SECT,aValName,aDef))
  else
    begin
      aVal := SetIniString(aDef);
      if LangIniFile.ValueExists(SECT_Translator,aVal)
      then aDef := GetIniString(LangIniFile.ReadString(SECT_Translator,aVal,aDef))
      else
        begin
          LangIniFile.WriteString(SECT,aValName,SetIniString(aDef));
          LangIniFile.WriteString(SECT_Translator,aVal,SetIniString(aDef));
          aDef := GetIniString(aDef);
        end;
      end;
end;

procedure LangStringsRead;
begin
  try
// Расчётный модуль
    ReadLangIniString(SECT_Res,'rsPeakNotFound',rsPeakNotFound);
    ReadLangIniString(SECT_Res,'rsCheckFonBegin',rsCheckFonBegin);
    ReadLangIniString(SECT_Res,'rsCheckFonSlant',rsCheckFonSlant);
    ReadLangIniString(SECT_Res,'rsCheckFonCentre',rsCheckFonCentre);
    ReadLangIniString(SECT_Res,'rsCheckFonRight',rsCheckFonRight);
    ReadLangIniString(SECT_Res,'rsCheckPeak5CentreRight',rsCheckPeak5CentreRight);
    ReadLangIniString(SECT_Res,'rsCheckPeak5CentreLeft',rsCheckPeak5CentreLeft);
    ReadLangIniString(SECT_Res,'rsCheckPeak4CentreRight',rsCheckPeak4CentreRight);
    ReadLangIniString(SECT_Res,'rsCheckPeak4CentreLeft',rsCheckPeak4CentreLeft);
    ReadLangIniString(SECT_Res,'rsCheckPeakGA1min',rsCheckPeakGA1min);
    ReadLangIniString(SECT_Res,'rsCheckPeakGA1max',rsCheckPeakGA1max);
    ReadLangIniString(SECT_Res,'rsCheckPeakDGA2',rsCheckPeakDGA2);
    ReadLangIniString(SECT_Res,'rsCheckPeakGSL',rsCheckPeakGSL);
    ReadLangIniString(SECT_Res,'rsCheckPeakGSR',rsCheckPeakGSR);
    ReadLangIniString(SECT_Res,'rsFonBy0TooLow',rsFonBy0TooLow);
    ReadLangIniString(SECT_Res,'rsFonBy0TooHigh',rsFonBy0TooHigh);
    ReadLangIniString(SECT_Res,'rsFonBx0TooLow',rsFonBx0TooLow);
    ReadLangIniString(SECT_Res,'rsFonBx0TooHigh',rsFonBx0TooHigh);
    ReadLangIniString(SECT_Res,'rsFonBtNegative',rsFonBtNegative);
    ReadLangIniString(SECT_Res,'rsFonBtTooLow',rsFonBtTooLow);
    ReadLangIniString(SECT_Res,'rsFonBtTooHigh',rsFonBtTooHigh);
    ReadLangIniString(SECT_Res,'rsDozaNotFound',rsDozaNotFound);
    ReadLangIniString(SECT_Res,'rsFonAfterPeakTooRight',rsFonAfterPeakTooRight);
    ReadLangIniString(SECT_Res,'rsFonAfterPeakAbsent',rsFonAfterPeakAbsent);
    ReadLangIniString(SECT_Res,'rsExitNotifyIfManualChange',rsExitNotifyIfManualChange);
    ReadLangIniString(SECT_Res,'rsFailureDetectorLoad',rsFailureDetectorLoad);
    ReadLangIniString(SECT_Res,'rsUserOptions',rsUserOptions);
    ReadLangIniString(SECT_Res,'rsAutoCalc',rsAutoCalc);
    ReadLangIniString(SECT_Res,'rsManualChanges',rsManualChanges);
    ReadLangIniString(SECT_Res,'rsAutoCalcFromDB',rsAutoCalcFromDB);
    ReadLangIniString(SECT_Res,'rsManualChangesFromDB',rsManualChangesFromDB);
    ReadLangIniString(SECT_Res,'rsBackgroundFailure',rsBackgroundFailure);
    ReadLangIniString(SECT_Res,'rsPeakSimulated',rsPeakSimulated);
    ReadLangIniString(SECT_Res,'rsWarning',rsWarning);
    ReadLangIniString(SECT_Res,'rsCommonView',rsCommonView);
    ReadLangIniString(SECT_Res,'rsBackgroundView',rsBackgroundView);
    ReadLangIniString(SECT_Res,'rsPeakView',rsPeakView);
    ReadLangIniString(SECT_Res,'rsYes',rsYes);
    ReadLangIniString(SECT_Res,'rsNo',rsNo);
    ReadLangIniString(SECT_Res,'rsCancel',rsCancel);
    ReadLangIniString(SECT_Res,'rsChartCalcTitle',rsChartCalcTitle);
    ReadLangIniString(SECT_Res,'rsBrookenMeasure',rsBrookenMeasure);
    ReadLangIniString(SECT_Res,'rsFitFonTiltle',rsFitFonTiltle);
    ReadLangIniString(SECT_Res,'rsFitPeakTiltle',rsFitPeakTiltle);
    ReadLangIniString(SECT_Res,'rsSuquare',rsSuquare);
    ReadLangIniString(SECT_Res,'rsCalcFormError',rsCalcFormError);

// База данных
    ReadLangIniString(SECT_Res,'rsDBNoConnection',rsDBNoConnection);
    ReadLangIniString(SECT_Res,'rsDBConnectionFault',rsDBConnectionFault);
    ReadLangIniString(SECT_Res,'rsDBConnectionFault_ASIDK',rsDBConnectionFault_ASIDK);
// Окно "О программе"
    ReadLangIniString(SECT_Res,'rsVersion',rsVersion);
    ReadLangIniString(SECT_Res,'rsInformation',rsInformation);
// COM-порт
    ReadLangIniString(SECT_Res,'rsOpenPort',rsOpenPort);
    ReadLangIniString(SECT_Res,'rsCantOpenPort',rsCantOpenPort);
    ReadLangIniString(SECT_Res,'rsPortInitError',rsPortInitError);
    ReadLangIniString(SECT_Res,'rsEmulator',rsEmulator);
// Пользователи и права
    ReadLangIniString(SECT_Res,'rsIncorrectLoginPass',rsIncorrectLoginPass);
    ReadLangIniString(SECT_Res,'rsFIO',rsFIO);
    ReadLangIniString(SECT_Res,'rsCantDelCurrentUser',rsCantDelCurrentUser);
    ReadLangIniString(SECT_Res,'rsUserAlreadyExist',rsUserAlreadyExist);
    ReadLangIniString(SECT_Res,'rsUserNameIsNotValid',rsUserNameIsNotValid);
// Дозиметры
    ReadLangIniString(SECT_Res,'rsDosimeter',rsDosimeter);
    ReadLangIniString(SECT_Res,'rsDosimeterType',rsDosimeterType);
    ReadLangIniString(SECT_Res,'rsDosСalibrated',rsDosCalibrated);
    ReadLangIniString(SECT_Res,'rsDosNotСalibrated',rsDosNotCalibrated);
    ReadLangIniString(SECT_Res,'rsDosDecommissioned',rsDosDecommissioned);
    ReadLangIniString(SECT_Res,'rsDosUnknown',rsDosUnknown);
    ReadLangIniString(SECT_Res,'rsDosDose',rsDosDose);
    ReadLangIniString(SECT_Res,'rsDosK',rsDosK);
    ReadLangIniString(SECT_Res,'rsDosMeasStatus',rsDosMeasStatus);
    ReadLangIniString(SECT_Res,'rsDosStatus',rsDosStatus);
// Детекторы
    ReadLangIniString(SECT_Res,'rsD',rsD);
    ReadLangIniString(SECT_Res,'rsDetector',rsDetector);
    ReadLangIniString(SECT_Res,'rsDetector1',rsDetector1);
    ReadLangIniString(SECT_Res,'rsDetector2',rsDetector2);
    ReadLangIniString(SECT_Res,'rsDetector3',rsDetector3);
    ReadLangIniString(SECT_Res,'rsDetector4',rsDetector4);
// Состояния измерения
    ReadLangIniString(SECT_Res,'rsDosNotMeasured',rsDosNotMeasured);
    ReadLangIniString(SECT_Res,'rsDosMeasErr',rsDosMeasErr);
    ReadLangIniString(SECT_Res,'rsDosMeasWarning',rsDosMeasWarning);
    ReadLangIniString(SECT_Res,'rsDosMeasForProcessing',rsDosMeasForProcessing);
    ReadLangIniString(SECT_Res,'rsDosFinished',rsDosFinished);
    ReadLangIniString(SECT_Res,'rsDosAccepted',rsDosAccepted);
// Журнал действий оператора
    ReadLangIniString(SECT_Res,'rsTime',rsTime);
    ReadLangIniString(SECT_Res,'rsComboBox1Minute',rsComboBox1Minute);
    ReadLangIniString(SECT_Res,'rsComboBox10Minutes',rsComboBox10Minutes);
    ReadLangIniString(SECT_Res,'rsComboBox1Hour',rsComboBox1Hour);
    ReadLangIniString(SECT_Res,'rsComboBox8Hour',rsComboBox8Hour);
    ReadLangIniString(SECT_Res,'rsComboBox1Day',rsComboBox1Day);
    ReadLangIniString(SECT_Res,'rsComboBox1Week',rsComboBox1Week);
    ReadLangIniString(SECT_Res,'rsComboBox1Month',rsComboBox1Month);
// Фильтр
    ReadLangIniString(SECT_Res,'rsFltOrg',rsFltOrg);
    ReadLangIniString(SECT_Res,'rsFltDep',rsFltDep);
    ReadLangIniString(SECT_Res,'rsFltPart',rsFltPart);
    ReadLangIniString(SECT_Res,'rsFltDosType',rsFltDosType);
    ReadLangIniString(SECT_Res,'rsFltDosStatus',rsFltDosStatus);
    ReadLangIniString(SECT_Res,'rsFltPersNumber',rsFltPersNumber);
    ReadLangIniString(SECT_Res,'rsFltIDK',rsFltIDK);
    ReadLangIniString(SECT_Res,'rsFltMeasTime',rsFltMeasTime);
    ReadLangIniString(SECT_Res,'rsFltMeasTimeFrom',rsFltMeasTimeFrom);
    ReadLangIniString(SECT_Res,'rsFltMeasTimeTo',rsFltMeasTimeTo);
    ReadLangIniString(SECT_Res,'rsFltMeasStatus',rsFltMeasStatus);
    ReadLangIniString(SECT_Res,'rsFltMeasComment',rsFltMeasComment);
// Отчет
    ReadLangIniString(SECT_Res,'rsRptTitle',rsRptTitle);
    ReadLangIniString(SECT_Res,'rsTitleMeasTime',rsTitleMeasTime);
    ReadLangIniString(SECT_Res,'rsDateLabelMemo',rsDateLabelMemo);
    ReadLangIniString(SECT_Res,'rsRptError',rsRptError);
// Для логов
   ReadLangIniString(SECT_Res,'rsExit',rsExit);
   ReadLangIniString(SECT_Res,'rsEnter',rsEnter);
// Сообщения
    ReadLangIniString(SECT_Res,'rsMsgFileAlreadyExists',rsMsgFileAlreadyExists);
    ReadLangIniString(SECT_Res,'rsMsgWarning',rsMsgWarning);
    ReadLangIniString(SECT_Res,'rsMsgFoundInvalidMeasToCalibr',rsMsgFoundInvalidMeasToCalibr);
    ReadLangIniString(SECT_Res,'rsMsgNeedToUpdateDBOrClose',rsMsgNeedToUpdateDBOrClose);
    ReadLangIniString(SECT_Res,'rsMsgCalibrDiffParts',rsMsgCalibrDiffParts);
    ReadLangIniString(SECT_Res,'rsMsgCalibrAllPart',rsMsgCalibrAllPart);
// Выполнение измерений
    ReadLangIniString(SECT_Res,'rsSmDeviceIsReady',rsSmDeviceIsReady);
    ReadLangIniString(SECT_Res,'rsSmNoConnection',rsSmNoConnection);
    ReadLangIniString(SECT_Res,'rsSmKSIReading',rsSmKSIReading);
    ReadLangIniString(SECT_Res,'rsSmKSILbl',rsSmKSILbl);
    ReadLangIniString(SECT_Res,'rsSmContinueMeasuring',rsSmContinueMeasuring);
    ReadLangIniString(SECT_Res,'rsSmNext',rsSmNext);
    ReadLangIniString(SECT_Res,'rsSmLoadD1',rsSmLoadD1);
    ReadLangIniString(SECT_Res,'rsSmLoadD2',rsSmLoadD2);
    ReadLangIniString(SECT_Res,'rsSmLoadD3',rsSmLoadD3);
    ReadLangIniString(SECT_Res,'rsSmLoadD4',rsSmLoadD4);
    ReadLangIniString(SECT_Res,'rsSmWaitingLoad',rsSmWaitingLoad);
    ReadLangIniString(SECT_Res,'rsSmNotMeasured',rsSmNotMeasured);
    ReadLangIniString(SECT_Res,'rsSmLoadingDetectors',rsSmLoadingDetectors);
    ReadLangIniString(SECT_Res,'rsSmWaitingMeas',rsSmWaitingMeas);
    ReadLangIniString(SECT_Res,'rsSmWaitingMeasD1',rsSmWaitingMeasD1);
    ReadLangIniString(SECT_Res,'rsSmWaitingMeasD2',rsSmWaitingMeasD2);
    ReadLangIniString(SECT_Res,'rsSmWaitingMeasD3',rsSmWaitingMeasD3);
    ReadLangIniString(SECT_Res,'rsSmWaitingMeasD4',rsSmWaitingMeasD4);
    ReadLangIniString(SECT_Res,'rsSmMeasInProcess',rsSmMeasInProcess);
    ReadLangIniString(SECT_Res,'rsSmStoveHeating',rsSmStoveHeating);
    ReadLangIniString(SECT_Res,'rsSmStoveCooling',rsSmStoveCooling);
    ReadLangIniString(SECT_Res,'rsSmError',rsSmError);
    ReadLangIniString(SECT_Res,'rsSmMeasD1',rsSmMeasD1);
    ReadLangIniString(SECT_Res,'rsSmMeasD2',rsSmMeasD2);
    ReadLangIniString(SECT_Res,'rsSmMeasD3',rsSmMeasD3);
    ReadLangIniString(SECT_Res,'rsSmMeasD4',rsSmMeasD4);
    ReadLangIniString(SECT_Res,'rsSmMeasD1Finished',rsSmMeasD1Finished);
    ReadLangIniString(SECT_Res,'rsSmMeasD2Finished',rsSmMeasD2Finished);
    ReadLangIniString(SECT_Res,'rsSmMeasD3Finished',rsSmMeasD3Finished);
    ReadLangIniString(SECT_Res,'rsSmMeasD4Finished',rsSmMeasD4Finished);
    ReadLangIniString(SECT_Res,'rsSmErrorMeasD1',rsSmErrorMeasD1);
    ReadLangIniString(SECT_Res,'rsSmErrorMeasD2',rsSmErrorMeasD2);
    ReadLangIniString(SECT_Res,'rsSmErrorMeasD3',rsSmErrorMeasD3);
    ReadLangIniString(SECT_Res,'rsSmErrorMeasD4',rsSmErrorMeasD4);
    ReadLangIniString(SECT_Res,'rsSmMeasDosStopped',rsSmMeasDosStopped);
    ReadLangIniString(SECT_Res,'rsSmMeasFinished',rsSmMeasFinished);
    ReadLangIniString(SECT_Res,'rsSmWarning',rsSmWarning);
    ReadLangIniString(SECT_Res,'rsSmProcessedWarning',rsSmProcessedWarning);
    ReadLangIniString(SECT_Res,'rsSmProcessedError',rsSmProcessedError);
    ReadLangIniString(SECT_Res,'rsSmMeasSucceed',rsSmMeasSucceed);
    ReadLangIniString(SECT_Res,'rsSmMeasAccepted',rsSmMeasAccepted);
    ReadLangIniString(SECT_Res,'rsSmMeasError',rsSmMeasError);
    ReadLangIniString(SECT_Res,'rsSmDetLost',rsSmDetLost);
    ReadLangIniString(SECT_Res,'rsSmDetBroken',rsSmDetBroken);
    ReadLangIniString(SECT_Res,'rsSmDetSkipped',rsSmDetSkipped);
    ReadLangIniString(SECT_Res,'rsSmMeasDate',rsSmMeasDate);
    ReadLangIniString(SECT_Res,'rsSmMeasID',rsSmMeasID);
    ReadLangIniString(SECT_Res,'rsSmKS',rsSmKS);
    ReadLangIniString(SECT_Res,'rsSmMeasStatus',rsSmMeasStatus);
    ReadLangIniString(SECT_Res,'rsSmRegistrationDate',rsSmRegistrationDate);
    ReadLangIniString(SECT_Res,'rsSmVerificationDate',rsSmVerificationDate);
    ReadLangIniString(SECT_Res,'rsSmCommentToMeas',rsSmCommentToMeas);
    ReadLangIniString(SECT_Res,'rsSmCommentToDos',rsSmCommentToDos);
    ReadLangIniString(SECT_Res,'rsSmTLDUser',rsSmTLDUser);
    ReadLangIniString(SECT_Res,'rsSmTldID',rsSmTldID);
    ReadLangIniString(SECT_Res,'rsSmMeasShort',rsSmMeasShort);
    ReadLangIniString(SECT_Res,'rsSmLastMeasComment',rsSmLastMeasComment);
    ReadLangIniString(SECT_Res,'rsSmLastMeasStatus',rsSmLastMeasStatus);
    ReadLangIniString(SECT_Res,'rsSmLastMeasTime',rsSmLastMeasTime);
    ReadLangIniString(SECT_Res,'rsSmDosimeters',rsSmDosimeters);
    ReadLangIniString(SECT_Res,'rsSmCalibrDose',rsSmCalibrDose);
    ReadLangIniString(SECT_Res,'rsSmDoseType',rsSmDoseType);
// Импорт дозиметров
    ReadLangIniString(SECT_Res,'rsImpAddedRecord',rsImpAddedRecord);
    ReadLangIniString(SECT_Res,'rsImpUpdatedRecord',rsImpUpdatedRecord);
    ReadLangIniString(SECT_Res,'rsImpAddedRecords',rsImpAddedRecords);
    ReadLangIniString(SECT_Res,'rsImpUpdatedRecords',rsImpUpdatedRecords);
    ReadLangIniString(SECT_Res,'rsImpFindedErrors',rsImpFindedErrors);
    ReadLangIniString(SECT_Res,'rsImpErrFindingDosType',rsImpErrFindingDosType);
    ReadLangIniString(SECT_Res,'rsImpErrFindingDetType',rsImpErrFindingDetType);
    ReadLangIniString(SECT_Res,'rsImpCantFindDosType',rsImpCantFindDosType);
    ReadLangIniString(SECT_Res,'rsImpCantFindDetType',rsImpCantFindDetType);
    ReadLangIniString(SECT_Res,'rsImpAddRecordSuccess',rsImpAddRecordSuccess);
    ReadLangIniString(SECT_Res,'rsImpAddRecordErr',rsImpAddRecordErr);
    ReadLangIniString(SECT_Res,'rsImpUpdateDosTypeSuccess',rsImpUpdateDosTypeSuccess);
    ReadLangIniString(SECT_Res,'rsImpUpdateDosTypeErr',rsImpUpdateDosTypeErr);
    ReadLangIniString(SECT_Res,'rsImpUpdateDetTypeSuccess',rsImpUpdateDetTypeSuccess);
    ReadLangIniString(SECT_Res,'rsImpUpdateDetTypeErr',rsImpUpdateDetTypeErr);
    ReadLangIniString(SECT_Res,'rsImpUpdateDos',rsImpUpdateDos);
    ReadLangIniString(SECT_Res,'rsImpUpdateDosErr',rsImpUpdateDosErr);
    ReadLangIniString(SECT_Res,'rsImpBackupTableErr',rsImpBackupTableErr);
    ReadLangIniString(SECT_Res,'rsImpDropTableErr',rsImpDropTableErr);
    ReadLangIniString(SECT_Res,'rsImpDosExistErr',rsImpDosExistErr);
    ReadLangIniString(SECT_Res,'rsImpDosTypeExistErr',rsImpDosTypeExistErr);
    ReadLangIniString(SECT_Res,'rsImpDetTypeExistErr',rsImpDetTypeExistErr);
    ReadLangIniString(SECT_Res,'rsImpTableExistErr',rsImpTableExistErr);
    ReadLangIniString(SECT_Res,'rsImpRanameTableErr',rsImpRanameTableErr);
    ReadLangIniString(SECT_Res,'rsImpSQLScriptSuccess',rsImpSQLScriptSuccess);
    ReadLangIniString(SECT_Res,'rsImpSQLScriptErr',rsImpSQLScriptErr);
    ReadLangIniString(SECT_Res,'rsImpInformation',rsImpInformation);

    ReadLangIniString(SECT_Res,'rsImpDosListBuilding',rsImpDosListBuilding);
    ReadLangIniString(SECT_Res,'rsImpDosTypeListBuilding',rsImpDosTypeListBuilding);
    ReadLangIniString(SECT_Res,'rsImpDetTypeListBuilding',rsImpDetTypeListBuilding);
    ReadLangIniString(SECT_Res,'rsImpSettingsListBuilding',rsImpSettingsListBuilding);
    ReadLangIniString(SECT_Res,'rsImpMeasListBuilding',rsImpMeasListBuilding);
    ReadLangIniString(SECT_Res,'rsImpDosType',rsImpDosType);
    ReadLangIniString(SECT_Res,'rsImpDetType',rsImpDetType);
    ReadLangIniString(SECT_Res,'rsImpMeas',rsImpMeas);
    ReadLangIniString(SECT_Res,'rsImpSettings',rsImpSettings);
    ReadLangIniString(SECT_Res,'rsImpDos',rsImpDos);

// Единицы измернения
    ReadLangIniString(SECT_Res,'rsUntmSv',rsUntmSv);
    ReadLangIniString(SECT_Res,'rsUntmGy',rsUntmGy);
//Резервное копирование БД
    ReadLangIniString(SECT_Res,'rsBkErr',rsBkErr);
    ReadLangIniString(SECT_Res,'rsBkSuccess',rsBkSuccess);
// Прочие параметры

// uDetectorConstructorForm
    ReadLangIniString(SECT_Res,'rsProfileParamsEmpty', rsProfileParamsEmpty);
    ReadLangIniString(SECT_Res,'rsMethodEmpty', rsMethodEmpty);
    ReadLangIniString(SECT_Res,'rsMatherial', rsMatherial);
    ReadLangIniString(SECT_Res,'rsCalcMethod', rsCalcMethod);
    ReadLangIniString(SECT_Res,'rsDetectorParamsUpdated', rsDetectorParamsUpdated);
    ReadLangIniString(SECT_Res,'rsDeleteDetectorType', rsDeleteDetectorType);
    ReadLangIniString(SECT_Res,'rsErrDeleteDetectorType', rsErrDeleteDetectorType);
    ReadLangIniString(SECT_Res,'rsDetailInfoAtFile', rsDetailInfoAtFile);
    ReadLangIniString(SECT_Res,'rsDeleteDetectorTypeDenied', rsDeleteDetectorTypeDenied);
    ReadLangIniString(SECT_Res,'rsTemperatureProfile', rsTemperatureProfile);
// uDosimeterConstructorForm
    ReadLangIniString(SECT_Res,'rsInputCorrectKoeff', rsInputCorrectKoeff);
    ReadLangIniString(SECT_Res,'rsInputCorrectNewDosimeterNumbers',rsInputCorrectNewDosimeterNumbers);
    ReadLangIniString(SECT_Res,'rsDosimeterTypeRequired', rsDosimeterTypeRequired);
    ReadLangIniString(SECT_Res,'rsNewPartyAdded', rsNewPartyAdded);
    ReadLangIniString(SECT_Res,'rsErrNewPartyAdded', rsErrNewPartyAdded);
    ReadLangIniString(SECT_Res,'rsPartyExists', rsPartyExists);
    ReadLangIniString(SECT_Res,'rsPartyReform', rsPartyReform);
    ReadLangIniString(SECT_Res,'rsNeedPartyName', rsNeedPartyName);
    ReadLangIniString(SECT_Res,'rsDosimeterUpdated', rsDosimeterUpdated);
    ReadLangIniString(SECT_Res,'rsErrDosimeterUpdated', rsErrDosimeterUpdated);
    ReadLangIniString(SECT_Res,'rsDosimeterAdded', rsDosimeterAdded);
    ReadLangIniString(SECT_Res,'rsErrDosimeterAdded', rsErrDosimeterAdded);
    ReadLangIniString(SECT_Res,'rsErrDosimeterAddOrUpdated', rsErrDosimeterAddOrUpdated);
    ReadLangIniString(SECT_Res,'rsErrBuildDosimeterList', rsErrBuildDosimeterList);
// uDosimeterPartForm
    ReadLangIniString(SECT_Res,'rsErrDeleteParty', rsErrDeleteParty);
    ReadLangIniString(SECT_Res,'rsPartyName', rsPartyName);
    ReadLangIniString(SECT_Res,'rsParties', rsParties);
    ReadLangIniString(SECT_Res,'rsDeleteParty', rsDeleteParty);
    ReadLangIniString(SECT_Res,'rsDeletePartDosimetersExist', rsDeletePartDosimetersExist);
    ReadLangIniString(SECT_Res,'rsFoundMeasuresAfterCalibration', rsFoundMeasuresAfterCalibration);
    ReadLangIniString(SECT_Res,'rsNums', rsNums);
    ReadLangIniString(SECT_Res,'rsRecalcMeasuresAfterCalibration', rsRecalcMeasuresAfterCalibration);
    ReadLangIniString(SECT_Res,'rsRecalculation', rsRecalculation);
// uDosimeterTypeConstruction
    ReadLangIniString(SECT_Res,'rsTypeName', rsTypeName);
    ReadLangIniString(SECT_Res,'rsErrDeleteDosimeterType', rsErrDeleteDosimeterType);
    ReadLangIniString(SECT_Res,'rsDeleteType', rsDeleteType);
    ReadLangIniString(SECT_Res,'rsDenied', rsDenied);
    ReadLangIniString(SECT_Res,'rsNewDosimeterTypeRegistered', rsNewDosimeterTypeRegistered);
// uChangePassForm
    ReadLangIniString(SECT_Res,'rsChangeUserPasswordQuery', rsChangeUserPasswordQuery);
    ReadLangIniString(SECT_Res,'rsChangeUserPassword', rsChangeUserPassword);
    ReadLangIniString(SECT_Res,'rsAccessRightsTemplate', rsAccessRightsTemplate);
// uAddUserForm
    ReadLangIniString(SECT_Res,'rsAddedUser', rsAddedUser);
// uMainForm
    ReadLangIniString(SECT_Res,'rsSoftwareName',rsSoftwareName);
    ReadLangIniString(SECT_Res,'rsLogStartTest',rsLogStartTest);
    ReadLangIniString(SECT_Res,'rsDBConnectionOK',rsDBConnectionOK);
    ReadLangIniString(SECT_Res,'rsDB',rsDB);
    ReadLangIniString(SECT_Res,'rsDBisNotOpen',rsDBisNotOpen);
    ReadLangIniString(SECT_Res,'rsDBConnectionFaultShort',rsDBConnectionFaultShort);
    ReadLangIniString(SECT_Res,'rsDB_ASIDK',rsDB_ASIDK);
    ReadLangIniString(SECT_Res,'rsDB_ASIDKConnestionOK',rsDB_ASIDKConnestionOK);
    ReadLangIniString(SECT_Res,'rsDB_ASIDKisNotOpen',rsDB_ASIDKisNotOpen);
    ReadLangIniString(SECT_Res,'rsDB_ASIDKConnectionFaultShort',rsDB_ASIDKConnectionFaultShort);
    ReadLangIniString(SECT_Res,'rsUserRightsChanged',rsUserRightsChanged);
    ReadLangIniString(SECT_Res,'rsChartTitle',rsChartTitle);
    ReadLangIniString(SECT_Res,'rsReservedCopyName',rsReservedCopyName);
    ReadLangIniString(SECT_Res,'rsDBSaveFault',rsDBSaveFault);
    ReadLangIniString(SECT_Res,'rsDBFindNewRecIndex',rsDBFindNewRecIndex);
    ReadLangIniString(SECT_Res,'rsDBConnectionError',rsDBConnectionError);
    ReadLangIniString(SECT_Res,'rsDB_ASIDKConnectionError',rsDB_ASIDKConnectionError);
    ReadLangIniString(SECT_Res,'rsDBErrorFound',rsDBErrorFound);
    ReadLangIniString(SECT_Res,'rsAuthentificationError',rsAuthentificationError);
    ReadLangIniString(SECT_Res,'rsLogoutDeniedWhenMeas',rsLogoutDeniedWhenMeas);
    ReadLangIniString(SECT_Res,'rsKeyExitPressed',rsKeyExitPressed);
    ReadLangIniString(SECT_Res,'rsPressYesWhenAgry',rsPressYesWhenAgry);
    ReadLangIniString(SECT_Res,'rsBackupBackupFiles',rsBackupBackupFiles);
    ReadLangIniString(SECT_Res,'rsBackupSqlFiles',rsBackupSqlFiles);
    ReadLangIniString(SECT_Res,'rsBackupFiles',rsBackupFiles);
    ReadLangIniString(SECT_Res,'rsDBCurrentVersion',rsDBCurrentVersion);
    ReadLangIniString(SECT_Res,'rsDBUpgradeNeeded',rsDBUpgradeNeeded);
    ReadLangIniString(SECT_Res,'rsDBUpgradeSuccess',rsDBUpgradeSuccess);
    ReadLangIniString(SECT_Res,'rsDBUpgradeError',rsDBUpgradeError);
    ReadLangIniString(SECT_Res,'rsCircling',rsCircling);
    ReadLangIniString(SECT_Res,'rsCheckUpgrade',rsCheckUpgrade);
    ReadLangIniString(SECT_Res,'rsDBVersionNotChanged',rsDBVersionNotChanged);
    ReadLangIniString(SECT_Res,'rsDBCreateReservFailure',rsDBCreateReservFailure);
    ReadLangIniString(SECT_Res,'rsProgramWillClosed',rsProgramWillClosed);
    ReadLangIniString(SECT_Res,'rsDBVersion',rsDBVersion);
    ReadLangIniString(SECT_Res,'rsDBVersionTooMatch',rsDBVersionTooMatch);
    ReadLangIniString(SECT_Res,'rsNeedUpdateSsoft',rsNeedUpdateSsoft);
    ReadLangIniString(SECT_Res,'rsDeleteDosimetersGroup',rsDeleteDosimetersGroup);
    ReadLangIniString(SECT_Res,'rsDeleteDosimetersFailure',rsDeleteDosimetersFailure);
    ReadLangIniString(SECT_Res,'rsDeleteDosimetersSuccess',rsDeleteDosimetersSuccess);
    ReadLangIniString(SECT_Res,'rsNoDosimetersForDel',rsNoDosimetersForDel);
    ReadLangIniString(SECT_Res,'rsDeleteDosimeters',rsDeleteDosimeters);
    ReadLangIniString(SECT_Res,'rsDeleteErrorsFailure',rsDeleteErrorsFailure);
    ReadLangIniString(SECT_Res,'rsDeleteMeasures',rsDeleteMeasures);
    ReadLangIniString(SECT_Res,'rsDeletedMeasuresAbsent',rsDeletedMeasuresAbsent);
    ReadLangIniString(SECT_Res,'rsDeleteDBAsk',rsDeleteDBAsk);
    ReadLangIniString(SECT_Res,'rsDeleteDB',rsDeleteDB);
    ReadLangIniString(SECT_Res,'rsDeletedDB',rsDeletedDB);
    ReadLangIniString(SECT_Res,'rsDBDeleteFailure',rsDBDeleteFailure);
    ReadLangIniString(SECT_Res,'rsDBDeleteOpenDenied',rsDBDeleteOpenDenied);
    ReadLangIniString(SECT_Res,'rsPartyExclude',rsPartyExclude);
    ReadLangIniString(SECT_Res,'rsPartyExcludeOne',rsPartyExcludeOne);
    ReadLangIniString(SECT_Res,'rsDBExport',rsDBExport);
    ReadLangIniString(SECT_Res,'rsDBExportTo',rsDBExportTo);
    ReadLangIniString(SECT_Res,'rsDBExportDenied',rsDBExportDenied);
    ReadLangIniString(SECT_Res,'rsDBExportDenied2',rsDBExportDenied2);
    ReadLangIniString(SECT_Res,'rsExportDone',rsExportDone);
    ReadLangIniString(SECT_Res,'rsExportDone2',rsExportDone2);
    ReadLangIniString(SECT_Res,'rsToFile',rsToFile);
    ReadLangIniString(SECT_Res,'rsDBExportDeniedNoFile',rsDBExportDeniedNoFile);
    ReadLangIniString(SECT_Res,'rsFileNotFound',rsFileNotFound);
    ReadLangIniString(SECT_Res,'rsDBImport',rsDBImport);
    ReadLangIniString(SECT_Res,'rsDBImportFromReserved',rsDBImportFromReserved);
    ReadLangIniString(SECT_Res,'rsDBImportDone',rsDBImportDone);
    ReadLangIniString(SECT_Res,'rsDBImportFailure',rsDBImportFailure);
    ReadLangIniString(SECT_Res,'rsDBWorkChecked',rsDBWorkChecked);
    ReadLangIniString(SECT_Res,'rsDBChooseWorkForImport',rsDBChooseWorkForImport);
    ReadLangIniString(SECT_Res,'rsMeasuring',rsMeasuring);
    ReadLangIniString(SECT_Res,'rsTestStarted',rsTestStarted);
    ReadLangIniString(SECT_Res,'rsMeasurementDone',rsMeasurementDone);
    ReadLangIniString(SECT_Res,'rsHardResetFound',rsHardResetFound);
    ReadLangIniString(SECT_Res,'rsSaveTemperatures',rsSaveTemperatures);
    ReadLangIniString(SECT_Res,'rsSrcData',rsSrcData);
    ReadLangIniString(SECT_Res,'rsGot',rsGot);
    ReadLangIniString(SECT_Res,'rsSaveToDB',rsSaveToDB);
    ReadLangIniString(SECT_Res,'rsData',rsData);
    ReadLangIniString(SECT_Res,'rsCalculated',rsCalculated);
    ReadLangIniString(SECT_Res,'rsShowed',rsShowed);
    ReadLangIniString(SECT_Res,'rsLostConnectionWhenMeasure',rsLostConnectionWhenMeasure);
    ReadLangIniString(SECT_Res,'rsDosimetersGroupToOut',rsDosimetersGroupToOut);
    ReadLangIniString(SECT_Res,'rsDosimeterOut',rsDosimeterOut);
    ReadLangIniString(SECT_Res,'rsDosimeterOutFailure',rsDosimeterOutFailure);
    ReadLangIniString(SECT_Res,'rsNotChooseDosimeterOut',rsNotChooseDosimeterOut);
    ReadLangIniString(SECT_Res,'rsDeleteMeasuresGroupAsk',rsDeleteMeasuresGroupAsk);
    ReadLangIniString(SECT_Res,'rsDeleteMeasureFailure',rsDeleteMeasureFailure);
    ReadLangIniString(SECT_Res,'rsOfDosimeter',rsOfDosimeter);
    ReadLangIniString(SECT_Res,'rsDeleteMeasureAsk',rsDeleteMeasureAsk);
    ReadLangIniString(SECT_Res,'rsNotChooseMeasureToDel',rsNotChooseMeasureToDel);
    ReadLangIniString(SECT_Res,'rsNotChooseMeasure',rsNotChooseMeasure);
    ReadLangIniString(SECT_Res,'rsDeleteUserAsk',rsDeleteUserAsk);
    ReadLangIniString(SECT_Res,'rsUserDeleted',rsUserDeleted);
    ReadLangIniString(SECT_Res,'rsSaveChanges4MeasGroup',rsSaveChanges4MeasGroup);
    ReadLangIniString(SECT_Res,'rsNotBind',rsNotBind);
    ReadLangIniString(SECT_Res,'rsBind',rsBind);
    ReadLangIniString(SECT_Res,'rsLoadingFilters',rsLoadingFilters);
    ReadLangIniString(SECT_Res,'rsLoadingPageDosimeters',rsLoadingPageDosimeters);
    ReadLangIniString(SECT_Res,'rsLoadingPageEdit',rsLoadingPageEdit);
    ReadLangIniString(SECT_Res,'rsLoadingPageMeasuring',rsLoadingPageMeasuring);
    ReadLangIniString(SECT_Res,'rsLoadingPageCalibration',rsLoadingPageCalibration);
    ReadLangIniString(SECT_Res,'rsApplicationStartedEarlier',rsApplicationStartedEarlier);
    ReadLangIniString(SECT_Res,'rsCRCFailure',rsCRCFailure);
    ReadLangIniString(SECT_Res,'rsFilterSet',rsFilterSet);
    ReadLangIniString(SECT_Res,'rsMotorFailure',rsMotorFailure);
    ReadLangIniString(SECT_Res,'rsHeaterFailure',rsHeaterFailure);
    ReadLangIniString(SECT_Res,'rsConnectionFailure',rsConnectionFailure);
    ReadLangIniString(SECT_Res,'rsPanelConnectionFailure',rsPanelConnectionFailure);
    ReadLangIniString(SECT_Res,'rsBigDose',rsBigDose);
    ReadLangIniString(SECT_Res,'rsCRCError',rsCRCError);
    ReadLangIniString(SECT_Res,'rsPort',rsPort);
    ReadLangIniString(SECT_Res,'rsReInited',rsReInited);
    ReadLangIniString(SECT_Res,'rsReInitFailure',rsReInitFailure);
    ReadLangIniString(SECT_Res,'rsDifferentDosimeterTypes',rsDifferentDosimeterTypes);
    ReadLangIniString(SECT_Res,'rsDifDosimeterTypesDetail',rsDifDosimeterTypesDetail);
    ReadLangIniString(SECT_Res,'rsCreateDidntWork',rsCreateDidntWork);
    ReadLangIniString(SECT_Res,'rsDosimeterRecalc',rsDosimeterRecalc);
    ReadLangIniString(SECT_Res,'rsNotDefined',rsNotDefined);
    ReadLangIniString(SECT_Res,'rsProcessing',rsProcessing);
    ReadLangIniString(SECT_Res,'rsConfirmSelfPermit',rsConfirmSelfPermit);
    ReadLangIniString(SECT_Res,'rsStopBeforeStart',rsStopBeforeStart);
//uMyComPort
    ReadLangIniString(SECT_Res,'rsGetCOMPortFailure',rsGetCOMPortFailure);
    ReadLangIniString(SECT_Res,'rsGetTimeOutsFailure',rsGetTimeOutsFailure);
    ReadLangIniString(SECT_Res,'rsSetTimeOutsFailure',rsSetTimeOutsFailure);
    ReadLangIniString(SECT_Res,'rsGetDataComPortFailure',rsGetDataComPortFailure);
    ReadLangIniString(SECT_Res,'rsSendComPortFailure',rsSendComPortFailure);
//uSetConnection
    ReadLangIniString(SECT_Res,'rsErrStartPos0',rsErrStartPos0);
//uTLDCommand
    ReadLangIniString(SECT_Res,'rsErrSetRate',rsErrSetRate);
    ReadLangIniString(SECT_Res,'rsErrCalcModBusCRC',rsErrCalcModBusCRC);
    ReadLangIniString(SECT_Res,'rsEmulatorAnswer',rsEmulatorAnswer);
    ReadLangIniString(SECT_Res,'rsConnectionIsOn',rsConnectionIsOn);
    ReadLangIniString(SECT_Res,'rsEmulationIsOn',rsEmulationIsOn);
    ReadLangIniString(SECT_Res,'rsNoAnswer',rsNoAnswer);
    ReadLangIniString(SECT_Res,'rsPortConnection',rsPortConnection);
    ReadLangIniString(SECT_Res,'rsReturned',rsReturned);
    ReadLangIniString(SECT_Res,'rsLoast',rsLost);
    ReadLangIniString(SECT_Res,'rsRecall',rsRecall);
    ReadLangIniString(SECT_Res,'rsErrCommand',rsErrCommand);
    ReadLangIniString(SECT_Res,'rsCommandDone',rsCommandDone);
    ReadLangIniString(SECT_Res,'rsCommandDoing',rsCommandDoing);
    ReadLangIniString(SECT_Res,'rsCommandOverlay',rsCommandOverlay);
    ReadLangIniString(SECT_Res,'rsCommandNoExecutable',rsCommandNoExecutable);
    ReadLangIniString(SECT_Res,'rsCommandBreakByUser',rsCommandBreakByUser);
    ReadLangIniString(SECT_Res,'rsSendWaitTimeout',rsSendWaitTimeout);
    ReadLangIniString(SECT_Res,'rsAnswerTrace',rsAnswerTrace);
    ReadLangIniString(SECT_Res,'rsTimeOutMotor1',rsTimeOutMotor1);
    ReadLangIniString(SECT_Res,'rsTimeOutMotor2',rsTimeOutMotor2);
    ReadLangIniString(SECT_Res,'rsJamming',rsJamming);
    ReadLangIniString(SECT_Res,'rsJammingDetail',rsJammingDetail);
    ReadLangIniString(SECT_Res,'rsOffsetMotor1',rsOffsetMotor1);
    ReadLangIniString(SECT_Res,'rsOffsetMotor2',rsOffsetMotor2);
    ReadLangIniString(SECT_Res,'rsNeedRepair',rsNeedRepair);
    ReadLangIniString(SECT_Res,'rsGapNotFound1',rsGapNotFound1);
    ReadLangIniString(SECT_Res,'rsGapNotFound2',rsGapNotFound2);
    ReadLangIniString(SECT_Res,'rsWeekSignal1',rsWeekSignal1);
    ReadLangIniString(SECT_Res,'rsWeekSignal2',rsWeekSignal2);
    ReadLangIniString(SECT_Res,'rsErrESPPZU',rsErrESPPZU);
    ReadLangIniString(SECT_Res,'rsHeatTooMatch',rsHeatTooMatch);
    ReadLangIniString(SECT_Res,'rsFalseParameter1',rsFalseParameter1);
    ReadLangIniString(SECT_Res,'rsErrHeaterCRC',rsErrHeaterCRC);
    ReadLangIniString(SECT_Res,'rsFalseParameter2',rsFalseParameter2);
    ReadLangIniString(SECT_Res,'rsHeaterTPBreak',rsHeaterTPBreak);
    ReadLangIniString(SECT_Res,'rsTooHiTempWhenStart',rsTooHiTempWhenStart);
    ReadLangIniString(SECT_Res,'rsMechError',rsMechError);
    ReadLangIniString(SECT_Res,'rsMechErrorDetail',rsMechErrorDetail);
    ReadLangIniString(SECT_Res,'rsCoinsidenceCRC',rsCoinsidenceCRC);
    ReadLangIniString(SECT_Res,'rsErrCoinsidenceCRC',rsErrCoinsidenceCRC);
    ReadLangIniString(SECT_Res,'rsErrCRC',rsErrCRC);
    ReadLangIniString(SECT_Res,'rsErrCRCDetail',rsErrCRCDetail);
    ReadLangIniString(SECT_Res,'rsMeasurementStopped',rsMeasurementStopped);
    ReadLangIniString(SECT_Res,'rsErrPlaceNotFound',rsErrPlaceNotFound);
    ReadLangIniString(SECT_Res,'rsCommandReset',rsCommandReset);
    ReadLangIniString(SECT_Res,'rsPlaceControl',rsPlaceControl);
    ReadLangIniString(SECT_Res,'rsLoadD1',rsLoadD1);
    ReadLangIniString(SECT_Res,'rsLoadD2',rsLoadD2);
    ReadLangIniString(SECT_Res,'rsLoadD3',rsLoadD3);
    ReadLangIniString(SECT_Res,'rsLoadD4',rsLoadD4);
    ReadLangIniString(SECT_Res,'rsMeasurementD1',rsMeasurementD1);
    ReadLangIniString(SECT_Res,'rsMeasurementD2',rsMeasurementD2);
    ReadLangIniString(SECT_Res,'rsMeasurementD3',rsMeasurementD3);
    ReadLangIniString(SECT_Res,'rsMeasurementD4',rsMeasurementD4);
    ReadLangIniString(SECT_Res,'rsHeaterUp',rsHeaterUp);
    ReadLangIniString(SECT_Res,'rsHeaterDown',rsHeaterDown);
    ReadLangIniString(SECT_Res,'rsReadCSS',rsReadCSS);
    ReadLangIniString(SECT_Res,'rsReadTempProfile',rsReadTempProfile);
    ReadLangIniString(SECT_Res,'rsSaveTempProfile',rsSaveTempProfile);
    ReadLangIniString(SECT_Res,'rsStartMeasurement',rsStartMeasurement);
    ReadLangIniString(SECT_Res,'rsStopMeasurement',rsStopMeasurement);
    ReadLangIniString(SECT_Res,'rsReadMeasurement',rsReadMeasurement);
    ReadLangIniString(SECT_Res,'rsReadPlace',rsReadPlace);
    ReadLangIniString(SECT_Res,'rsReadDeviceInfo',rsReadDeviceInfo);
    ReadLangIniString(SECT_Res,'rsSaveDeviceNumber',rsSaveDeviceNumber);
    ReadLangIniString(SECT_Res,'rsSaveDeviceHWVersion',rsSaveDeviceHWVersion);
    ReadLangIniString(SECT_Res,'rsSaveEEPROM',rsSaveEEPROM);
    ReadLangIniString(SECT_Res,'rsCommonRepeat',rsCommonRepeat);
    ReadLangIniString(SECT_Res,'rsMotorsReadDeviceNumber ',rsMotorsReadDeviceNumber);
    ReadLangIniString(SECT_Res,'rsMotorsSetPosition',rsMotorsSetPosition);
    ReadLangIniString(SECT_Res,'rsMotorsReadProgress',rsMotorsReadProgress);
    ReadLangIniString(SECT_Res,'rsMotorsStop',rsMotorsStop);;
    ReadLangIniString(SECT_Res,'rsMotorsInit',rsMotorsInit);;
    ReadLangIniString(SECT_Res,'rsMotorsInit1_252',rsMotorsInit1_252);
    ReadLangIniString(SECT_Res,'rsMotorsInit1_251',rsMotorsInit1_251);
    ReadLangIniString(SECT_Res,'rsMotorsReadBase',rsMotorsReadBase);
    ReadLangIniString(SECT_Res,'rsMotorsReadRWParams1',rsMotorsReadRWParams1);
    ReadLangIniString(SECT_Res,'rsMotorsReadRWParams2',rsMotorsReadRWParams2);
    ReadLangIniString(SECT_Res,'rsMotorsPowerLine1On',rsMotorsPowerLine1On);
    ReadLangIniString(SECT_Res,'rsMotorsPowerLine2On',rsMotorsPowerLine2On);
    ReadLangIniString(SECT_Res,'rsMotorsPowerLine1Off',rsMotorsPowerLine1Off);
    ReadLangIniString(SECT_Res,'rsMotorsPowerLine2Off',rsMotorsPowerLine2Off);
    ReadLangIniString(SECT_Res,'rsMotorsPowerLine3On',rsMotorsPowerLine3On);
    ReadLangIniString(SECT_Res,'rsMotorsPowerLine3Off',rsMotorsPowerLine3Off);
    ReadLangIniString(SECT_Res,'rsMotorsWriteDigitalOutput ',rsMotorsWriteDigitalOutput);
    ReadLangIniString(SECT_Res,'rsMotorsWriteParams4One ',rsMotorsWriteParams4One);
    ReadLangIniString(SECT_Res,'rsMotorsWriteEEPROM',rsMotorsWriteEEPROM);
    ReadLangIniString(SECT_Res,'rsMotorsWriteStatParams ',rsMotorsWriteStatParams);
    ReadLangIniString(SECT_Res,'rsMotorCommandDone',rsMotorCommandDone);
    ReadLangIniString(SECT_Res,'rsMotorCommandDoneWErr',rsMotorCommandDoneWErr);
    ReadLangIniString(SECT_Res,'rsAirHeatReadAll',rsAirHeatReadAll);
    ReadLangIniString(SECT_Res,'rsAirHeatReadHolding',rsAirHeatReadHolding);
    ReadLangIniString(SECT_Res,'rsAirHeatReadInput',rsAirHeatReadInput);
    ReadLangIniString(SECT_Res,'rsAirHeatWriteProfile',rsAirHeatWriteProfile);
    ReadLangIniString(SECT_Res,'rsAirHeatWriteBurnProfile ',rsAirHeatWriteBurnProfile);
    ReadLangIniString(SECT_Res,'rsAirHeatWriteStatus',rsAirHeatWriteStatus);
    ReadLangIniString(SECT_Res,'rsAirHeatA1',rsAirHeatA1);
    ReadLangIniString(SECT_Res,'rsAirHeatA2',rsAirHeatA2);
    ReadLangIniString(SECT_Res,'rsAirHeatA3',rsAirHeatA3);
    ReadLangIniString(SECT_Res,'rsAirHeatA5_inKTV',rsAirHeatA5_inKTV);
    ReadLangIniString(SECT_Res,'rsAirHeatReadedTemp',rsAirHeatReadedTemp);
    ReadLangIniString(SECT_Res,'rsAirHeatA6',rsAirHeatA6);
    ReadLangIniString(SECT_Res,'rsMonitorReadAll',rsMonitorReadAll);
    ReadLangIniString(SECT_Res,'rsMonitorWriteAll',rsMonitorWriteAll);
    ReadLangIniString(SECT_Res,'rsMonitorInit',rsMonitorInit);
    ReadLangIniString(SECT_Res,'rsMonitorM1',rsMonitorM1);
    ReadLangIniString(SECT_Res,'rsMonitorM2',rsMonitorM2);
    ReadLangIniString(SECT_Res,'rsMonitorM3',rsMonitorM3);
    ReadLangIniString(SECT_Res,'rsMonitorM4',rsMonitorM4);
    ReadLangIniString(SECT_Res,'rsPMTReadAll',rsPMTReadAll);
    ReadLangIniString(SECT_Res,'rsPMTWriteAll',rsPMTWriteAll);
    ReadLangIniString(SECT_Res,'rsPMTP1',rsPMTP1);
    ReadLangIniString(SECT_Res,'rsPMTNewReadBase',rsPMTReadBase);
    ReadLangIniString(SECT_Res,'rsPMTNewReadNumChan',rsPMTReadNumChan);
    ReadLangIniString(SECT_Res,'rsPMTNewReadKTV',rsPMTReadKTV);
    ReadLangIniString(SECT_Res,'rsPMTNewStart',rsPMTStart);
    ReadLangIniString(SECT_Res,'rsPMTNewSetTime',rsPMTSetTime);
    ReadLangIniString(SECT_Res,'rsPMTWaitDone',rsPMTWaitDone);;
    ReadLangIniString(SECT_Res,'rsPMTNewSleep',rsPMTNewSleep);;
    ReadLangIniString(SECT_Res,'rsPMTNewReatKTV',rsPMTNewReatKTV);
    ReadLangIniString(SECT_Res,'rsPMTNewSwitch1',rsPMTNewSwitch1);
    ReadLangIniString(SECT_Res,'rsPMTNewSwitch2',rsPMTNewSwitch2);
    ReadLangIniString(SECT_Res,'rsPMTNewSwitch3',rsPMTNewSwitch3);
    ReadLangIniString(SECT_Res,'rsPMTNewDarkCurStart',rsPMTNewDarkCurStart);
    ReadLangIniString(SECT_Res,'rsPMTNewSrcCurStart',rsPMTNewSrcCurStart);
    ReadLangIniString(SECT_Res,'rsPMTNewSetTargetTemperature',rsPMTNewSetTargetTemperature);
    ReadLangIniString(SECT_Res,'rsPMTNewSetControlTime',rsPMTNewSetControlTime);
    ReadLangIniString(SECT_Res,'rsPMTNewSetDevNumber',rsPMTNewSetDevNumber);
    ReadLangIniString(SECT_Res,'rsPMTNewGetDevNumber',rsPMTNewGetDevNumber);
    ReadLangIniString(SECT_Res,'rsScanStartRead',rsScanStartRead);
    ReadLangIniString(SECT_Res,'rsScanReadBase',rsScanReadBase);
    ReadLangIniString(SECT_Res,'rsScanReadBarCode',rsScanReadBarCode);
    ReadLangIniString(SECT_Res,'rsUserPanelCommand',rsUserPanelCommand);
    ReadLangIniString(SECT_Res,'rsScanFailed',rsScanFailed);;
    ReadLangIniString(SECT_Res,'rsCommonCheckBeforeSwapping ',rsCommonCheckBeforeSwapping);
    ReadLangIniString(SECT_Res,'rsBadCheckBeforeSwapping ',rsBadCheckBeforeSwapping);
    ReadLangIniString(SECT_Res,'rsCommonCheckCassA_Down ',rsCommonCheckCassA_Down);
    ReadLangIniString(SECT_Res,'rsCommonCheckCassB_Down ',rsCommonCheckCassB_Down);
    ReadLangIniString(SECT_Res,'rsCommonCheckCassAB_Up ',rsCommonCheckCassAB_Up);
    ReadLangIniString(SECT_Res,'rsCommonBadCheckCassA_Down ',rsCommonBadCheckCassA_Down);
    ReadLangIniString(SECT_Res,'rsCommonBadCheckCassB_Down ',rsCommonBadCheckCassB_Down);
    ReadLangIniString(SECT_Res,'rsCommonBadCassAB_Up',rsCommonBadCassAB_Up);
    ReadLangIniString(SECT_Res,'rsCommonCheckDarkCurrent ',rsCommonCheckDarkCurrent);
    ReadLangIniString(SECT_Res,'rsCommonBadDarkCurrent ',rsCommonBadDarkCurrent);
    ReadLangIniString(SECT_Res,'rsCommonCheckCICurrent ',rsCommonCheckCICurrent);
    ReadLangIniString(SECT_Res,'rsCommonBadCICurrent',rsCommonBadCICurrent);
    ReadLangIniString(SECT_Res,'rsCommonChooseMode',rsCommonChooseMode);
    ReadLangIniString(SECT_Res,'rsCommonCheckScan',rsCommonCheckScan);
    ReadLangIniString(SECT_Res,'rsReturnIfMeasure',rsReturnIfMeasure);
    ReadLangIniString(SECT_Res,'rsCommonCheckEndMeasure ',rsCommonCheckEndMeasure);
    ReadLangIniString(SECT_Res,'rsCommonCallBurning',rsCommonCallBurning);
    ReadLangIniString(SECT_Res,'rsCommonBurningOn',rsCommonBurningOn);
    ReadLangIniString(SECT_Res,'rsNoCheckScan',rsNoCheckScan);
    ReadLangIniString(SECT_Res,'rsCheckScan',rsCheckScan);
    ReadLangIniString(SECT_Res,'rsDisableScanerUseManual ',rsDisableScanerUseManual);
    ReadLangIniString(SECT_Res,'rsCommonGoInit',rsCommonGoInit);
    ReadLangIniString(SECT_Res,'rsCommonGoIdle',rsCommonGoIdle);
    ReadLangIniString(SECT_Res,'rsTargetPMTTempFailure ',rsTargetPMTTempFailure);
    ReadLangIniString(SECT_Res,'rsFailureMotorsCommon',rsFailureMotorsCommon);
    ReadLangIniString(SECT_Res,'rsMotorsInitRequired',rsMotorsInitRequired);
    ReadLangIniString(SECT_Res,'rsMotorsGo4Required',rsMotorsGo4Required);
    ReadLangIniString(SECT_Res,'rsCheckFiltrFailure',rsCheckFiltrFailure);
    ReadLangIniString(SECT_Res,'rsCommonGoMotorsInit',rsCommonGoMotorsInit);
    ReadLangIniString(SECT_Res,'rsCommonCheckMotorsInit ',rsCommonCheckMotorsInit);
    ReadLangIniString(SECT_Res,'rsCommonCheckMotor2',rsCommonCheckMotor2);
    ReadLangIniString(SECT_Res,'rsCommonCheckMotor3',rsCommonCheckMotor3);
    ReadLangIniString(SECT_Res,'rsCommonCheckScan4Empty ',rsCommonCheckScan4Empty);
    ReadLangIniString(SECT_Res,'rsCommonCheckAir',rsCommonCheckAir);
    ReadLangIniString(SECT_Res,'rsCommonCall',rsCommonCall);;
    ReadLangIniString(SECT_Res,'rsCommonReturn',rsCommonReturn);
    ReadLangIniString(SECT_Res,'rsCasseteMotRecognized ',rsCasseteMotRecognized);
    ReadLangIniString(SECT_Res,'rsCasseteFound',rsCasseteFound);
    ReadLangIniString(SECT_Res,'rsCommonGoPushOut',rsCommonGoPushOut);
    ReadLangIniString(SECT_Res,'rsCommonGoSwapping',rsCommonGoSwapping);
    ReadLangIniString(SECT_Res,'rsCommonCallMotorsToStart ',rsCommonCallMotorsToStart);
    ReadLangIniString(SECT_Res,'rsCommonGoMeasuring',rsCommonGoMeasuring);
    ReadLangIniString(SECT_Res,'rsCommonCallCheckAir',rsCommonCallCheckAir);
    ReadLangIniString(SECT_Res,'rsGetMeasureDone',rsGetMeasureDone);
    ReadLangIniString(SECT_Res,'rsCommonCheckEndTime',rsCommonCheckEndTime);
    ReadLangIniString(SECT_Res,'rsDelay5',rsDelay5);;
    ReadLangIniString(SECT_Res,'rsFirstTimeStarted',rsFirstTimeStarted);
    ReadLangIniString(SECT_Res,'rsWaitTimeDone',rsWaitTimeDone);
    ReadLangIniString(SECT_Res,'rsCommonCallDelay',rsCommonCallDelay);
    ReadLangIniString(SECT_Res,'rsInternalError',rsInternalError);
    ReadLangIniString(SECT_Res,'rsCommonCheckUserAnswer ',rsCommonCheckUserAnswer);
    ReadLangIniString(SECT_Res,'rsCommonUITitle',rsCommonUITitle);
    ReadLangIniString(SECT_Res,'rsCommonUICheckEnd',rsCommonUICheckEnd);
    ReadLangIniString(SECT_Res,'rsCommonUIStopByUser',rsCommonUIStopByUser);
    ReadLangIniString(SECT_Res,'rsCommonUserAnswerOk',rsCommonUserAnswerOk);
    ReadLangIniString(SECT_Res,'rsCommonUserAnswerRetry ',rsCommonUserAnswerRetry);
    ReadLangIniString(SECT_Res,'rsCommonUserAnswerCancel ',rsCommonUserAnswerCancel);
    ReadLangIniString(SECT_Res,'rsCommonUserAnswerAbort ',rsCommonUserAnswerAbort);
    ReadLangIniString(SECT_Res,'rsCommonUserAutoAnswered ',rsCommonUserAutoAnswered);
    ReadLangIniString(SECT_Res,'rsCommonUserPanelAnswered ',rsCommonUserPanelAnswered);
    ReadLangIniString(SECT_Res,'rsCommonMotorsStarted',rsCommonMotorsStarted);
    ReadLangIniString(SECT_Res,'rsMotorsFailure',rsMotorsFailure);
    ReadLangIniString(SECT_Res,'rsCommonNoDosimeter',rsCommonNoDosimeter);
    ReadLangIniString(SECT_Res,'rsCommonBadScan',rsCommonBadScan);
    ReadLangIniString(SECT_Res,'rsAccLowFlow',rsAccLowFlow);;
    ReadLangIniString(SECT_Res,'rsAccUnknown',rsAccUnknown);;
    ReadLangIniString(SECT_Res,'rsMotorsBoardConFail',rsMotorsBoardConFail);
    ReadLangIniString(SECT_Res,'rsAirHeatBoardConFail',rsAirHeatBoardConFail);
    ReadLangIniString(SECT_Res,'rsMonitorBoardConFail',rsMonitorBoardConFail);
    ReadLangIniString(SECT_Res,'rsPMTBoardConFail',rsPMTBoardConFail);
    ReadLangIniString(SECT_Res,'rsScanBoardConFail',rsScanBoardConFail);
    ReadLangIniString(SECT_Res,'rsPMTNewConFail',rsPMTNewConFail);
    ReadLangIniString(SECT_Res,'rscStartSingleMeas',rscStartSingleMeas);
    ReadLangIniString(SECT_Res,'rscStartSeriaMeas',rscStartSeriaMeas);
    ReadLangIniString(SECT_Res,'rscStartCalibration',rscStartCalibration);
    ReadLangIniString(SECT_Res,'rscTesting',rscTesting);;
    ReadLangIniString(SECT_Res,'rscBurning',rscBurning);;
    ReadLangIniString(SECT_Res,'rscIrradiation',rscIrradiation);
    ReadLangIniString(SECT_Res,'rscGrading',rscGrading);;
    ReadLangIniString(SECT_Res,'rscRegistration',rscRegistration);
    ReadLangIniString(SECT_Res,'rsUnknownProcess',rsUnknownProcess);
    ReadLangIniString(SECT_Res,'rsInit',rsInit);
    ReadLangIniString(SECT_Res,'rsIdle',rsIdle);

//uControl
    ReadLangIniString(SECT_Res,'rsToSaveTempProfile',rsToSaveTempProfile);
    ReadLangIniString(SECT_Res,'rsFileWritten',rsFileWritten);

//uStartMF
    ReadLangIniString(SECT_Res,'rsInputDosimeterNumber',rsInputDosimeterNumber);
    ReadLangIniString(SECT_Res,'rsDosNumMustStartCiph',rsDosNumMustStartCiph);
    ReadLangIniString(SECT_Res,'rsImageNotFound',rsImageNotFound);
    ReadLangIniString(SECT_Res,'rsAddedDosimeter',rsAddedDosimeter);
    ReadLangIniString(SECT_Res,'rsErrAddedDosimeter',rsErrAddedDosimeter);
    ReadLangIniString(SECT_Res,'rsDosimeterNotFound',rsDosimeterNotFound);
    ReadLangIniString(SECT_Res,'rsGiveDosimeterType',rsGiveDosimeterType);
    ReadLangIniString(SECT_Res,'rsGiveDose',rsGiveDose);
    ReadLangIniString(SECT_Res,'rsGiveDosimeterNumber',rsGiveDosimeterNumber);
    ReadLangIniString(SECT_Res,'rsDosimeterNotInList',rsDosimeterNotInList);
    ReadLangIniString(SECT_Res,'rsCheckFilter',rsCheckFilter);
    ReadLangIniString(SECT_Res,'rsBack',rsBack);
    ReadLangIniString(SECT_Res,'rsIncorrectValue',rsIncorrectValue);
    ReadLangIniString(SECT_Res,'rsStartNewMeasurement',rsStartNewMeasurement);
    ReadLangIniString(SECT_Res,'rsGiveDosimeterNumber2',rsGiveDosimeterNumber2);
    ReadLangIniString(SECT_Res,'rsClose',rsClose);
    ReadLangIniString(SECT_Res,'rsSkipDetector',rsSkipDetector);
    ReadLangIniString(SECT_Res,'rsSkipDetectorWhy',rsSkipDetectorWhy);
    ReadLangIniString(SECT_Res,'rsSkipD1',rsSkipD1);
    ReadLangIniString(SECT_Res,'rsSkipD2',rsSkipD2);
    ReadLangIniString(SECT_Res,'rsSkipD3',rsSkipD3);
    ReadLangIniString(SECT_Res,'rsSkipD4',rsSkipD4);
    ReadLangIniString(SECT_Res,'rsMeasSerieEnd',rsMeasSerieEnd);
    ReadLangIniString(SECT_Res,'rsCalibrationPrepare',rsCalibrationPrepare);
//uDataModule
    ReadLangIniString(SECT_Res,'rsDosimetersDeleted',rsDosimetersDeleted);
    ReadLangIniString(SECT_Res,'rsNoDeletedDosimeters',rsNoDeletedDosimeters);
    ReadLangIniString(SECT_Res,'rsErrDeleteDosimeters',rsErrDeleteDosimeters);
    ReadLangIniString(SECT_Res,'rsErrCreateDBReserved',rsErrCreateDBReserved);
    ReadLangIniString(SECT_Res,'rsErrDBConnection',rsErrDBConnection);
    ReadLangIniString(SECT_Res,'rsPartyDeleted',rsPartyDeleted);
    ReadLangIniString(SECT_Res,'rsErrPartyDeleted',rsErrPartyDeleted);
    ReadLangIniString(SECT_Res,'rsDosTypeDeleted',rsDosTypeDeleted);
    ReadLangIniString(SECT_Res,'rsErrDosTypeDeleted',rsErrDosTypeDeleted);
    ReadLangIniString(SECT_Res,'rsDetTypeDeleted',rsDetTypeDeleted);
    ReadLangIniString(SECT_Res,'rsErrDetTypeDeleted',rsErrDetTypeDeleted);
    ReadLangIniString(SECT_Res,'rsMeasuresDeleted',rsMeasuresDeleted);
    ReadLangIniString(SECT_Res,'rsMeasures4DelAbcent',rsMeasures4DelAbcent);
    ReadLangIniString(SECT_Res,'rsMeasures4DelNotDeleted',rsMeasures4DelNotDeleted);
    ReadLangIniString(SECT_Res,'rsErrDosimeterExcludeParty',rsErrDosimeterExcludeParty);
    ReadLangIniString(SECT_Res,'rsMeasChecked4Del',rsMeasChecked4Del);
    ReadLangIniString(SECT_Res,'rsErrMeasChecked4Del',rsErrMeasChecked4Del);
    ReadLangIniString(SECT_Res,'rsNewDetTypeAdded',rsNewDetTypeAdded);
    ReadLangIniString(SECT_Res,'rsErrNewDetTypeAdded',rsErrNewDetTypeAdded);
    ReadLangIniString(SECT_Res,'rsErrNewPartyAdded2',rsErrNewPartyAdded2);
    ReadLangIniString(SECT_Res,'rsNewDosTypeAdded',rsNewDosTypeAdded);
    ReadLangIniString(SECT_Res,'rsErrNewDosTypeAdded',rsErrNewDosTypeAdded);
    ReadLangIniString(SECT_Res,'rsDosimeter4Testing',rsDosimeter4Testing);
    ReadLangIniString(SECT_Res,'rsNoTable',rsNoTable);
    ReadLangIniString(SECT_Res,'rsErrCheckTable',rsErrCheckTable);
    ReadLangIniString(SECT_Res,'rsErrFormPartyName',rsErrFormPartyName);
    ReadLangIniString(SECT_Res,'rsErrGetDetDose',rsErrGetDetDose);
    ReadLangIniString(SECT_Res,'rsErrFindDetType',rsErrFindDetType);
    ReadLangIniString(SECT_Res,'rsMeasurement',rsMeasurement);
    ReadLangIniString(SECT_Res,'rsErrFindParty',rsErrFindParty);
    ReadLangIniString(SECT_Res,'rsErrCalcDosimetersAtParty',rsErrCalcDosimetersAtParty);
    ReadLangIniString(SECT_Res,'rsErrDefDosTypeAtParty',rsErrDefDosTypeAtParty);
    ReadLangIniString(SECT_Res,'rsErrFindDosType',rsErrFindDosType);
    ReadLangIniString(SECT_Res,'rsErrFindFormulaID',rsErrFindFormulaID);
    ReadLangIniString(SECT_Res,'rsErrFindIDDosType',rsErrFindIDDosType);
    ReadLangIniString(SECT_Res,'rsDBbyFileRefresh',rsDBbyFileRefresh);
    ReadLangIniString(SECT_Res,'rsErrDBbyFileRefresh',rsErrDBbyFileRefresh);
    ReadLangIniString(SECT_Res,'rsErrDBRefresh',rsErrDBRefresh);
    ReadLangIniString(SECT_Res,'rsRefreshFileNotFound',rsRefreshFileNotFound);
    ReadLangIniString(SECT_Res,'rsDBCopyDone',rsDBCopyDone);
    ReadLangIniString(SECT_Res,'rsErrDBCopy',rsErrDBCopy);
    ReadLangIniString(SECT_Res,'rsDBRenameDone',rsDBRenameDone);
    ReadLangIniString(SECT_Res,'rsErrFindDBComment',rsErrFindDBComment);
    ReadLangIniString(SECT_Res,'rsErrChangeDosNumberInMeas',rsErrChangeDosNumberInMeas);
    ReadLangIniString(SECT_Res,'rsDBUpdate',rsDBUpdate);
//uOpenDB
    ReadLangIniString(SECT_Res,'rsErrDBImport',rsErrDBImport);
    ReadLangIniString(SECT_Res,'rsImportDone',rsImportDone);
    ReadLangIniString(SECT_Res,'rsImportConfigDone',rsImportConfigDone);
    ReadLangIniString(SECT_Res,'rsFileNotFound2',rsFileNotFound2);
    ReadLangIniString(SECT_Res,'rsDBCreated',rsDBCreated);
    ReadLangIniString(SECT_Res,'rsErrDBCreated',rsErrDBCreated);
    ReadLangIniString(SECT_Res,'rsErrDBExists',rsErrDBExists);
    ReadLangIniString(SECT_Res,'rsDataBase',rsDataBase);
    ReadLangIniString(SECT_Res,'rsDeleteDone',rsDeleteDone);
    ReadLangIniString(SECT_Res,'rsErrDeleteDB',rsErrDeleteDB);
    ReadLangIniString(SECT_Res,'rsExportImpossible',rsExportImpossible);
//uEnterDBName
    ReadLangIniString(SECT_Res,'rsEnterCorrectValue',rsEnterCorrectValue);
    ReadLangIniString(SECT_Res,'rsIllegalChar',rsIllegalChar);
    ReadLangIniString(SECT_Res,'rsInputName',rsInputName);
    ReadLangIniString(SECT_Res,'rsErrNameCiphFirst',rsErrNameCiphFirst);
//uLogPassForm
    ReadLangIniString(SECT_Res,'rsEnterUser',rsEnterUser);
    ReadLangIniString(SECT_Res,'rsErrUserListEmpty',rsErrUserListEmpty);
//uImportDosimeter);
    ReadLangIniString(SECT_Res,'rsDosimeterRefreshed',rsDosimeterRefreshed);
    ReadLangIniString(SECT_Res,'rsErrDosimeterRefreshed',rsErrDosimeterRefreshed);
    ReadLangIniString(SECT_Res,'rsErrAddOrRefrDos',rsErrAddOrRefrDos);
    ReadLangIniString(SECT_Res,'rsErrAddOrRefrDosType',rsErrAddOrRefrDosType);
    ReadLangIniString(SECT_Res,'rsErrAddOrRefrDetType',rsErrAddOrRefrDetType);
    ReadLangIniString(SECT_Res,'rsErrAddOrRefrSettings',rsErrAddOrRefrSettings);
    ReadLangIniString(SECT_Res,'rsErrAddMeas',rsErrAddMeas);
    ReadLangIniString(SECT_Res,'rsErrDosType',rsErrDosType);
    ReadLangIniString(SECT_Res,'rsErrExportDos',rsErrExportDos);
    ReadLangIniString(SECT_Res,'rsErrImportFile',rsErrImportFile);
//uModel
    ReadLangIniString(SECT_Res,'rsErrSave',rsErrSave);
//uCalibrationForm
    ReadLangIniString(SECT_Res,'rsFoundLateMeasures',rsFoundLateMeasures);
    ReadLangIniString(SECT_Res,'rsReCalcWNewCoeff',rsReCalcWNewCoeff);
    ReadLangIniString(SECT_Res,'rsNewPartyAdded2',rsNewPartyAdded2);
    ReadLangIniString(SECT_Res,'rsCoeffsChanged',rsCoeffsChanged);
    ReadLangIniString(SECT_Res,'rsErrCoeffChanged',rsErrCoeffChanged);
//uDosimeterForm
    ReadLangIniString(SECT_Res,'rsDoseIncorrect',rsDoseIncorrect);
//uImportDBForm
    ReadLangIniString(SECT_Res,'rsCreateDB',rsCreateDB);
    ReadLangIniString(SECT_Res,'rsErrDBImport3',rsErrDBImport3);
    ReadLangIniString(SECT_Res,'rsErrDBConfigImport',rsErrDBConfigImport);
    ReadLangIniString(SECT_Res,'rsDBAlreadyExists',rsDBAlreadyExists);
    ReadLangIniString(SECT_Res,'rsImportDB',rsImportDB);
//uReportForm
    ReadLangIniString(SECT_Res,'rsNumber',rsNumber);
    ReadLangIniString(SECT_Res,'rsType',rsType);
    ReadLangIniString(SECT_Res,'rsAllMeasures',rsAllMeasures);
    ReadLangIniString(SECT_Res,'rsRptReportReady',rsRptReportReady);
    ReadLangIniString(SECT_Res,'rsRptReportBuildig',rsRptReportBuildig);
    ReadLangIniString(SECT_Res,'rsRptRecordValuesExceeded',rsRptRecordValuesExceeded);
    ReadLangIniString(SECT_Res,'rsRptMaximumValue',rsRptMaximumValue);
    ReadLangIniString(SECT_Res,'rsRptntNoSelectedRecords',rsRptntNoSelectedRecords);
//uImportInCurrentDBForm
    ReadLangIniString(SECT_Res,'rsImportDB2',rsImportDB2);
    ReadLangIniString(SECT_Res,'rsErrDBImport2',rsErrDBImport2);
    ReadLangIniString(SECT_Res,'rsDBImportDone2',rsDBImportDone2);
    ReadLangIniString(SECT_Res,'rsDBFileImportDone',rsDBFileImportDone);
    ReadLangIniString(SECT_Res,'rsErrDBFileImport',rsErrDBFileImport);
    ReadLangIniString(SECT_Res,'rsError',rsError);
    ReadLangIniString(SECT_Res,'rsErrDBName',rsErrDBName);
    ReadLangIniString(SECT_Res,'rsErrDBName2',rsErrDBName2);
    ReadLangIniString(SECT_Res,'rsErrDifferentKInPart',rsErrDifferentKInPart);
    ReadLangIniString(SECT_Res,'rsErrDifferentTypeInPart',rsErrDifferentTypeInPart);
    ReadLangIniString(SECT_Res,'rsErrDosWillNotBeAdded',rsErrDosWillNotBeAdded);
//uSQLFilterForm
    ReadLangIniString(SECT_Res,'rsDoneSucc',rsDoneSucc);
    ReadLangIniString(SECT_Res,'rsErrDid',rsErrDid);
    ReadLangIniString(SECT_Res,'rsFilter',rsFilter);
//uAddDosinQueue
    ReadLangIniString(SECT_Res,'rsDosimeterAlreadyExists',rsDosimeterAlreadyExists);
    ReadLangIniString(SECT_Res,'rsErrAddDosNum',rsErrAddDosNum);
//uQueeueForm
    ReadLangIniString(SECT_Res,'rsQueueMeasures',rsQueueMeasures);
    ReadLangIniString(SECT_Res,'rsAllCount',rsAllCount);
    ReadLangIniString(SECT_Res,'rsMeasID',rsMeasID);
    ReadLangIniString(SECT_Res,'rsErrNewDosTypeAdded2',rsErrNewDosTypeAdded2);
    ReadLangIniString(SECT_Res,'rsTypeNameExists',rsTypeNameExists);
    ReadLangIniString(SECT_Res,'rsSetTypeName',rsSetTypeName);
    ReadLangIniString(SECT_Res,'rsErrNewDetTypeAdded2',rsErrNewDetTypeAdded2);
    ReadLangIniString(SECT_Res,'rsDosNumDidntSet',rsDosNumDidntSet);
    ReadLangIniString(SECT_Res,'rsStateReset',rsStateReset);
//  uSendToCalibrForm
    ReadLangIniString(SECT_Res,'rsRadTypeGamma',rsRadTypeGamma);
    ReadLangIniString(SECT_Res,'rsRadTypeNeutron',rsRadTypeGamma);
// uStartIrradiation
    ReadLangIniString(SECT_Res,'rsIrradiationTime',rsIrradiationTime);
    ReadLangIniString(SECT_Res,'rsIrradiationEDR',rsIrradiationEDR);

  finally
  end;
end;

procedure TranslateValues(Preambula: String; Item: TComponent);
var
  c : TRttiContext;
  t : TRttiType;
  p : TRttiProperty;
//  v : TValue;
//  m : TRttiMethod;
  s : String;
  PropObject: TObject;
//  PropInfo: PPropInfo;
  i : integer;
  St: String;
  Sts: TStrings;
begin
  c := TRttiContext.Create;
  t := c.GetType(Item.ClassType);
  for p in t.GetProperties do
  try
    if p.PropertyType.TypeKind = tkUString then
    begin
      s := p.GetValue(Item).ToString;
      if s<>'' then
        if IsRussian(s) then
        begin
          ReadLangIniString(SECT_Forms,Preambula + '.' + p.Name,s);
          p.SetValue(Item,s);
        end;
    end;

    if (p.Name = 'Items') or (p.Name = 'Strings') or (p.Name = 'Lines') or (p.Name = 'TitleCaptions') then
    if p.PropertyType.TypeKind = tkClass then
    begin
      PropObject := GetObjectProp(Item, p.Name);
      if Assigned(PropObject)then
      begin
        if (PropObject is TStrings) then
        begin
          St :=(PropObject as TStrings).Text;
          if IsRussian(St) then
          begin
            if length(St)<200 then
            begin
              s := St;
              if s<>'' then
                if IsRussian(s) then
                begin
                  ReadLangIniString(SECT_Forms,Preambula + '.' + Item.Name,s);
                  (PropObject as TStrings).Text := s;
                end;
            end
              else
            begin
              Sts := TStringList.Create;
              try
                for i := 0 to (PropObject as TStrings).Count-1 do
                begin
                  St :=(PropObject as TStrings).Strings[i];
                  s := St;
                  if s<>'' then
                  begin
                    if IsRussian(s) then
                      ReadLangIniString(SECT_Forms,Preambula + '.' + Item.Name+'.String'+IntToStr(i),s);
                    Sts.Append(s);
                  end;
                end;
                (PropObject as TStrings).Clear;
                (PropObject as TStrings).AddStrings(Sts);
              finally
                Sts.Free;
              end
            end
          end;
        end;
      end
    end;

  except
  end;
end;

procedure TranslateComponent(Preambula: String; aComponent: TComponent);
var
  i: Integer;
  LangPrefix: String;
//  CompClassName : String;
begin
  if not UseLanguageFile then Exit;
  with aComponent do
  begin
    if Preambula=''
    then LangPrefix := Name
    else LangPrefix := Preambula + '.' + Name;
    TranslateValues(LangPrefix,aComponent);
    for i:=0 to aComponent.ComponentCount-1 do
      if Components[i] is TComponent then
        TranslateComponent(LangPrefix, Components[i]);
  end;
end;

procedure SaveFormImage(aForm: TForm; aDir,aName: String);
var
  JpegIm: TJpegImage;
  bm: TBitMap;
  r : TRect;
begin
  ForceDirectories(aDir);
  bm := TBitMap.Create;
  bm.Width := aForm.ClientWidth;
  bm.Height := aForm.ClientHeight;
  r := Classes.Rect(0, 0, bm.Width, bm.Height);
  bm.Canvas.CopyRect(r, aForm.Canvas, r);
//  BitBlt(bm.Canvas.Handle, 0, 0, bm.Width, bm.Height, GetDC(aForm.Handle), 0, 0, SRCCOPY);
  JpegIm := TJpegImage.Create;
  JpegIm.Assign(bm);
  JpegIm.CompressionQuality := 20;
  JpegIm.Compress;
  JpegIm.SaveToFile(aDir + aName + '.jpg');
  bm.Destroy;
  JpegIm.Destroy;
end;

procedure AllActiveFormsTranslate;
var
  i: integer;
begin
  LangStringsRead;
  if not UseLanguageFile then Exit;
  try
    if Application.ComponentCount <> 0 then
      for i := 0 to Application.ComponentCount-1 do
        if Application.Components[i].ClassParent = TForm then
        begin
          TranslateComponent(Application.Name,Application.Components[i] as TComponent);
        end;
  finally
  end;
end;

procedure SaveFormsToTranslateSection(aSect: String);
var
  SL: TStringList;
  FT1,FT2: TextFile;
  i: integer;
  St1,St2: String;
begin
  SL := TStringList.Create;
  AssignFile(FT1,extractfilepath(Application.ExeName)+aSect+'.tx1');
  AssignFile(FT2,extractfilepath(Application.ExeName)+aSect+'.txt');
  Rewrite(FT1);
  Rewrite(FT2);
  LangIniFile.ReadSectionValues(aSect, SL);
//  SL.SaveToFile(extractfilepath(Application.ExeName)+aSect+'.txt');
  for i := 0 to SL.Count-1 do
  begin
    St1 := SL.Names[i];
    St2 := SL.ValueFromIndex[i];
    Writeln(FT1,St1);
    Writeln(FT2,St2);
  end;
  CloseFile(FT1);
  CloseFile(FT2);
  SL.Free;
end;

procedure LoadLangTranslatedSection(aSect: String);
var
  SL: TStringList;
  FT1,FT2: TextFile;
//  i: integer;
  St1,St2: String;
begin
  SL := TStringList.Create;
  AssignFile(FT1,extractfilepath(Application.ExeName)+aSect+'.tx1');
  AssignFile(FT2,extractfilepath(Application.ExeName)+aSect+'.txt');
{$I-}
  Reset(FT1);
  Reset(FT2);
{$I+}
  while not EOF(FT1) do
  begin
    Readln(FT1,St1);
    Readln(FT2,St2);
    SL.Add(St1+'='+St2);
//    SL.AddPair(St1,St2);
//    SL.AddPair(St1,St2);
  end;
  SL.SaveToFile(extractfilepath(Application.ExeName)+aSect+'Translated.txt');
  CloseFile(FT1);
  CloseFile(FT2);
  SL.Free;
end;

  procedure SaveLangToTranslate;
  begin
    SaveFormsToTranslateSection('Strings');
    SaveFormsToTranslateSection('Translator');
    SaveFormsToTranslateSection('Forms');
  end;

  procedure LoadLangTranslated;
  begin
    LoadLangTranslatedSection('Strings');
    LoadLangTranslatedSection('Translator');
    LoadLangTranslatedSection('Forms');
  end;

procedure InitLanguage;
begin
  if Assigned(LangIniFile) then Exit;

  LangIniFile := TLangIniFile.Create(extractfilepath(Application.ExeName) + 'Language.ini');
  for iParamNumber:=1 to ParamCount do
    AppParamString := AppParamString + UpperCase(ParamStr(iParamNumber)); // параметры запуска программы
  if FileExists(LangIniFile.FileName) or
     (pos('/CREATE_LANGUAGE_FILES',AppParamString)>0) or
     (pos('/SEPARATE_LANGUAGE_FILES',AppParamString)>0) or
     (pos('/MERGE_LANGUAGE_FILES',AppParamString)>0)
  then
    UseLanguageFile := true; // признак использования языковых модификаций
  if (pos('/NO_LANGUAGE',AppParamString)>0) then
    UseLanguageFile := false; // ключ '/NO_LANGUAGE запрещает использование языков вовсе

  if pos('/SEPARATE_LANGUAGE_FILES',AppParamString)>0 then
    SaveLangToTranslate;
  if pos('/MERGE_LANGUAGE_FILES',AppParamString)>0 then
    LoadLangTranslated;
end;

procedure DestroyLanguage;
begin
  if not Assigned(LangIniFile) then Exit;

  if pos('/CREATE_LANGUAGE_FILES',AppParamString)>0 then
    LangIniFile.UpdateFile;

  LangIniFile.Free;
end;

initialization
  InitLanguage;

finalization
  DestroyLanguage;
end.
