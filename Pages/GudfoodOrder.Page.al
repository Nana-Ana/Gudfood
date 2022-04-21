page 50103 "Gudfood Order"
{
    PageType = Document;
    SourceTable = "Gudfood Order Header";
    Caption = 'Gudfood Order';

    layout
    {
        area(Content)
        {
            group(General)
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
            part("Gudfood Order Subpage"; "Gudfood Order Subpage")
            {
                SubPageLink = "Order No." = field("No.");
                Caption = 'Lines';
                UpdatePropagation = Both;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                ApplicationArea = All;
                Image = Post;

                trigger OnAction()
                begin
                    GudfoodOrderHeader.GET(rec."No.");
                    PostedGudfoodHeader.TransferFields(GudfoodOrderHeader);
                    PostedGudfoodHeader."Posting Date" := WorkDate();
                    PostedGudfoodHeader.Insert();
                    GudfoodOrderLine.SetRange("Order No.", rec."No.");
                    GudfoodOrderLine.FindSet();
                    REPEAT
                        PostedGudfoodOrderLine.TransferFields(GudfoodOrderLine);
                        PostedGudfoodOrderLine.Insert();
                    UNTIL GudfoodOrderLine.Next() = 0;
                    GudfoodOrderHeader.Delete(true);

                end;
            }
            action(Print)
            {
                Caption = 'Print';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(GudfoodOrderHeader);
                    Report.Run(50100, true, true, GudfoodOrderHeader);
                end;
            }
            action("Export Order")
            {
                Caption = 'Export Order';
                ApplicationArea = All;
                Image = Export;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(GudfoodOrderHeader);
                    Xmlport.Run(Xmlport::"Export Gudfood Order", false, false, GudfoodOrderHeader);
                end;
            }
            action("Dimensions")
            {
                Caption = 'Dimensions';
                ApplicationArea = All;
                Image = Dimensions;
                ShortcutKey = "Shift+Ctrl+D";
                AccessByPermission = TableData Dimension = R;

                trigger OnAction()
                begin
                    rec.ShowDocDim();
                    CurrPage.SaveRecord();
                end;
            }
        }
    }

    var
        PostedGudfoodHeader: Record "Posted Gudfood Order Header";
        GudfoodOrderLine: Record "Gudfood Order Line";
        GudfoodOrderHeader: Record "Gudfood Order Header";
        PostedGudfoodOrderLine: Record "Posted Gudfood Order Line";
}