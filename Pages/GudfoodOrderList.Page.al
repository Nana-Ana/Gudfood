page 50104 "Gudfood Order List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Gudfood Order Header";
    CardPageId = "Gudfood Order";
    Caption = 'Gudfood Order List';
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Export Orders,Dimensions';

    layout
    {
        area(Content)
        {

            repeater("Gudfood Order List")
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
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Export Orders")
            {
                Caption = 'Export Orders';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                Image = Export;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    Xmlport.Run(Xmlport::"Export Gudfood Order", FALSE, FALSE, Rec);
                end;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category5;
                Image = Dimensions;
                ShortcutKey = "Shift+Ctrl+D";
                AccessByPermission = TableData Dimension = R;

                trigger OnAction()
                begin
                    rec.ShowDocDim();
                end;
            }
        }
    }
}