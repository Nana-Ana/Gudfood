page 50102 "Gudfood Order Subpage"
{
    Caption = 'Gudfood Order Subpage';
    PageType = ListPart;
    SourceTable = "Gudfood Order Line";
    AutoSplitKey = true;
    PromotedActionCategories = 'New,Process,Report,Dimension';

    layout
    {
        area(Content)
        {
            repeater("Gudfood Order")
            {
                ShowCaption = false;

                field("Line No."; rec."Line No.")
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

                field("Date Created"; rec."Date Created")
                {
                    ApplicationArea = all;
                }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Dimension)
            {
                Caption = 'Dimension';

                Image = Dimensions;
                ShortcutKey = "Shift+Ctrl+D";
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                AccessByPermission = TableData Dimension = R;

                trigger OnAction()
                begin
                    Rec.ShowDimensions(Rec."Dimension Set ID", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code");
                end;
            }
        }
    }
}