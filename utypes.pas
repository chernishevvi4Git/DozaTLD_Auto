unit UTypes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
    // типы запускаемых процессов
    TProcessType=(
      cIdle,
      cInit,
      cStartSingleMeas,
      cStartSeriaMeas,
      cStartCalibration,
      cTesting,
      cBurning,
      cIrradiation,
      cGrading,
      cRegistration
    );


implementation

end.

