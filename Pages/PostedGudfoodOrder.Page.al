page 50109 "Posted Gudfood Order"
{
    PageType = Document;
    SourceTable = "Posted Gudfood Order Header";
    Editable = false;
    Caption = 'Posted Gudfood Order';

    layout
    {
        area(Content)
        {
            group("Posted Gudfood Order")
            {

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
            group("Order Line")
            {
                part("Posted Gudfood Order Subpage"; "Posted Gudfood Order Subpage")
                {
                    Caption = 'Lines';
                    SubPageLink = "Order No." = field("No.");
                    UpdatePropagation = Both;
                    ApplicationArea = all;
                }
            }
        }
    }
}