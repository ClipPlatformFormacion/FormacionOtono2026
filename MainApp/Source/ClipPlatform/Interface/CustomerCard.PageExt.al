namespace ClipPlatform.Interface;

using Microsoft.Sales.Customer;

pageextension 50105 "Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Customer Level"; Rec."Customer Level")
            {
                ApplicationArea = All;
            }
            field("Level Discount"; Rec."Level Discount")
            {
                ApplicationArea = All;
            }
        }
    }
}