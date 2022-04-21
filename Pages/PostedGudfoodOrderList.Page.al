page 50107 "Posted Gudfood Order List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Posted Gudfood Order Header";
    CardPageId = "Posted Gudfood Order";
    Caption = 'Posted Gudfood Order List';
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Export Orders,Dimensions';


    layout
    {
        area(Content)
        {
            repeater("Posted Gudfood Order List")
            {
                ShowCaption = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell- to Customer No."; rec."Sell- to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Sell- to Customer Name"; rec."Sell- to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Date Created"; rec."Date Created")
                {
                    ApplicationArea = all;
                }
                field("Total Qty."; rec."Total Qty.")
                {
                    ApplicationArea = all;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}