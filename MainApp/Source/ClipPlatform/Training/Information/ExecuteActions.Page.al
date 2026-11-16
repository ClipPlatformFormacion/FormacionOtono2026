namespace ClipPlatform.Training.Information;
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
        }
        area(Processing)
        {
            action(ExecuteQuery)
            {
                RunObject = Query "Training Information";
                image = Info;
            }
        }
    }
}