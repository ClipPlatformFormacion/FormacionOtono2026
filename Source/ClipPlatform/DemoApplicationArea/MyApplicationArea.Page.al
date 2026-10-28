namespace ClipPlatform.DemoApplicationArea;
using System.Environment.Configuration;

page 50105 "My Application Area"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Application Area Setup";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field(Training; Rec.Training) { }
                field(ADCS; Rec.ADCS)
                {
                    ToolTip = 'Specifies the value of the ADCS field.', Comment = '%';
                }
                field(Advanced; Rec.Advanced)
                {
                    ToolTip = 'Specifies the value of the Advanced field.', Comment = '%';
                }
                field("Assembly"; Rec."Assembly")
                {
                    ToolTip = 'Specifies the value of the Assembly field.', Comment = '%';
                }
                field(Basic; Rec.Basic)
                {
                    ToolTip = 'Specifies the value of the Basic field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.', Comment = '%';
                }
                field("Cost Accounting"; Rec."Cost Accounting")
                {
                    ToolTip = 'Specifies the value of the Cost Accounting field.', Comment = '%';
                }
                field("Item Budget"; Rec."Item Budget")
                {
                    ToolTip = 'Specifies the value of the Item Budget field.', Comment = '%';
                }
                field("Item Charges"; Rec."Item Charges")
                {
                    ToolTip = 'Specifies the value of the Item Charges field.', Comment = '%';
                }
                field("Inventory Analysis"; Rec."Inventory Analysis")
                {
                    ToolTip = 'Specifies the value of the Inventory Analysis field.', Comment = '%';
                }
                field("Fixed Assets"; Rec."Fixed Assets")
                {
                    ToolTip = 'Specifies the value of the Fixed Assets field.', Comment = '%';
                }
                field(Dimensions; Rec.Dimensions)
                {
                    ToolTip = 'Specifies the value of the Dimensions field.', Comment = '%';
                }
                field(Intercompany; Rec.Intercompany)
                {
                    ToolTip = 'Specifies the value of the Intercompany field.', Comment = '%';
                }
                field("Item References"; Rec."Item References")
                {
                    ToolTip = 'Specifies the value of the Item References field.', Comment = '%';
                }
                field(Service; Rec.Service)
                {
                    ToolTip = 'Specifies the value of the Service field.', Comment = '%';
                }
                field("Sales Return Order"; Rec."Sales Return Order")
                {
                    ToolTip = 'Specifies the value of the Sales Return Order field.', Comment = '%';
                }
                field("Sales Budget"; Rec."Sales Budget")
                {
                    ToolTip = 'Specifies the value of the Sales Budget field.', Comment = '%';
                }
                field(Reservation; Rec.Reservation)
                {
                    ToolTip = 'Specifies the value of the Reservation field.', Comment = '%';
                }
                field("Relationship Mgmt"; Rec."Relationship Mgmt")
                {
                    ToolTip = 'Specifies the value of the Relationship Mgmt field.', Comment = '%';
                }
                field("Record Links"; Rec."Record Links")
                {
                    ToolTip = 'Specifies the value of the Record Links field.', Comment = '%';
                }
                field("Purchase Analysis"; Rec."Purchase Analysis")
                {
                    ToolTip = 'Specifies the value of the Purchase Analysis field.', Comment = '%';
                }
                field("Purch Return Order"; Rec."Purch Return Order")
                {
                    ToolTip = 'Specifies the value of the Purch Return Order field.', Comment = '%';
                }
                field("Profile ID"; Rec."Profile ID")
                {
                    ToolTip = 'Specifies the value of the Profile ID field.', Comment = '%';
                }
                field(Planning; Rec.Planning)
                {
                    ToolTip = 'Specifies the value of the Planning field.', Comment = '%';
                }
                field("Order Promising"; Rec."Order Promising")
                {
                    ToolTip = 'Specifies the value of the Order Promising field.', Comment = '%';
                }
                field(Notes; Rec.Notes)
                {
                    ToolTip = 'Specifies the value of the Notes field.', Comment = '%';
                }
                field(Manufacturing; Rec.Manufacturing)
                {
                    ToolTip = 'Specifies the value of the Manufacturing field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                // TODO: ejemplo de Obsolete
                // field("Legacy Subcontracting"; Rec."Legacy Subcontracting")
                // {
                //     ToolTip = 'Specifies the value of the Legacy Subcontracting field.', Comment = '%';
                // }
                field(Jobs; Rec.Jobs)
                {
                    ToolTip = 'Specifies the value of the Projects field.', Comment = '%';
                }
                field("Item Tracking"; Rec."Item Tracking")
                {
                    ToolTip = 'Specifies the value of the Item Tracking field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(Suite; Rec.Suite)
                {
                    ToolTip = 'Specifies the value of the Suite field.', Comment = '%';
                }
                field("Sales Tax"; Rec."Sales Tax")
                {
                    ToolTip = 'Specifies the value of the Sales Tax field.', Comment = '%';
                }
                field("Sales Analysis"; Rec."Sales Analysis")
                {
                    ToolTip = 'Specifies the value of the Sales Analysis field.', Comment = '%';
                }
                field("Purchase Budget"; Rec."Purchase Budget")
                {
                    ToolTip = 'Specifies the value of the Purchase Budget field.', Comment = '%';
                }
                field(Prepayments; Rec.Prepayments)
                {
                    ToolTip = 'Specifies the value of the Prepayments field.', Comment = '%';
                }
                field(Warehouse; Rec.Warehouse)
                {
                    ToolTip = 'Specifies the value of the Warehouse field.', Comment = '%';
                }
                field(VAT; Rec.VAT)
                {
                    ToolTip = 'Specifies the value of the VAT field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("Basic ES"; Rec."Basic ES")
                {
                    ToolTip = 'Specifies the value of the Basic ES field.', Comment = '%';
                }
            }
        }
    }
}