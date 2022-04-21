page 50108 "Posted Gudfood Order Subpage"
{
    PageType = ListPart;
    SourceTable = "Posted Gudfood Order Line";
    AutoSplitKey = true;
    Editable = false;
    Caption = 'Posted Gudfood Order Subpage';
    PromotedActionCategories = 'New,Process,Report,Dimension';


    layout
    {
        area(Content)
        {
            repeater("Posted Gudfood Order")
            {
                ShowCaption = false;

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Sell- to Custo mer No."; rec."Sell- to Custo mer No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Type"; rec."Item Type")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}