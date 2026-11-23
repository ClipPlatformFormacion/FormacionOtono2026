namespace ClipPlatform.Training;
using Microsoft.Finance.RoleCenters;
pagecustomization "Business Manager Role Center" customizes "Business Manager Role Center"
{
    layout
    {
        modify("User Tasks Activities")
        {
            Visible = false;
        }
        moveafter(Control139; Emails)
    }

    actions
    {
        // Add changes to page actions here
    }
}