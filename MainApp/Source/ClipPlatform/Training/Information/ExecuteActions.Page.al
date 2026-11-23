namespace ClipPlatform.Training.Information;

using ClipPlatform.Training.ImportExport;
page 50106 "Execute Actions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    actions
    {
        area(Promoted)
        {
            actionref(ExecuteQueryPromoted; ExecuteQuery) { }
            actionref(ExecuteXMLPortPromoted; ExecuteXMLPort) { }
            actionref(ExecuteXMLPortTextPromoted; ExecuteXMLPortText) { }
        }
        area(Processing)
        {
            action(ExecuteQuery)
            {
                RunObject = Query "Training Information";
                image = Info;
            }
            action(ExecuteXMLPort)
            {
                RunObject = xmlport "Training";
                image = Info;
            }
            action(ExecuteXMLPortText)
            {
                RunObject = xmlport "Training Text";
                image = Info;
            }
        }
    }
}