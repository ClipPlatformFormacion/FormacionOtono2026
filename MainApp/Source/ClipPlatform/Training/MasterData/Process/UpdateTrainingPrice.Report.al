namespace ClipPlatform.Training.MasterData.Process;

using ClipPlatform.Training.MasterData;

report 50100 "Update Training Price"
{
    CaptionML = ENU = 'Update Training Price', ESP = 'Actualizar precio de formaciones';
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Training; Training)
        {
            RequestFilterFields = "No.", Blocked;
            trigger OnPreDataItem()
            begin
                Counter := 0;
                // Message('OnPreDataItem');
            end;

            trigger OnAfterGetRecord()
            begin
                Counter += 1;
                // Message('OnAfterGetRecord: %1', Training."No.");

                Training.Validate(Price, Training.Price * (1 + Percentage / 100));
                Training.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                Message('Se ha actualizado el precio en %1 formaciones', Counter);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options', ESP = 'Opciones';
                    field(PercentageControl; Percentage)
                    {
                        CaptionML = ENU = 'Percentage', ESP = 'Porcentaje';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            Percentage := 10;
        end;
    }

    trigger OnPreReport()
    begin
        if Percentage = 0 then
            Error('Percentage cannot be zero');
    end;

    var
        Counter: Integer;
        Percentage: Decimal;
}