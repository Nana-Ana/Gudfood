page 50101 "Gudfood Item Card"
{
    Caption = 'Gudfood Item Card';
    PageType = Card;
    CardPageId = "Gudfood Item List";
    SourceTable = "Gudfood Item";
    PromotedActionCategories = 'New,Porecess,Report,Dimensions';


    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; rec.Code)
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Shelf Life"; rec."Shelf Life")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
            }
            group("About Order")
            {
                field("Qty. Ordered"; rec."Qty. Ordered")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Qty. in Order"; rec."Qty. in Order")
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
            action(Dimensions)
            {
                Caption = 'Dimensoins';
                ApplicationArea = All;
                AccessByPermission = TableData Dimension = R;
                Promoted = true;
                PromotedCategory = Category4;
                Image = Dimensions;
                ShortcutKey = "Shift+Ctrl+D";
                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = CONST(50100), "No." = FIELD(Code);

            }
        }
    }
}