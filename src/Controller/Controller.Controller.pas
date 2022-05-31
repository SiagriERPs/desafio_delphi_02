unit Controller.Controller;

interface

uses
  Controller.Interfaces,Controller.Entidades;

  type
  TController = class(TInterfacedObject,iController)
    private
      FEntidades: iControllerEntidades;
    public
      constructor Create;
      destructor Destroy; override;
      class function New:iController;
      function Entidades: iControllerEntidades;

  end;






implementation

{ TController }

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

  inherited;
end;

class function TController.New: iController;
begin
  Result:=Self.Create;
end;

function TController.Entidades: iControllerEntidades;
begin
  if not Assigned(FEntidades) then
    FEntidades := TControllerEntidades.New;
  Result:= FEntidades;
end;

end.
