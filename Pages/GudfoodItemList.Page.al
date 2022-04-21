page 50100 "Gudfood Item List"
{
    Caption = 'Gudfood Item List';
    Editable = false;
    PageType = List;
    CardPageId = "Gudfood Item Card";
    SourceTable = "Gudfood Item";
    ApplicationArea = all;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Porecess,Report,Dimensions-Single,Dimensions-Multiple,';

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                ShowCaption = false;

                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                    Editable = false;
                    OptionCaption = ' ,Salat,Burger,Capcake,Drink';
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shelf Life"; rec."Shelf Life")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Qty. Ordered"; rec."Qty. Ordered")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Qty. in Order"; rec."Qty. in Order")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Dimensions-Single")
            {
                Caption = 'Dimensions-Single';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Category4;
                ShortcutKey = "Shift+Ctrl+D";
                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = CONST(50100), "No." = FIELD(Code);
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
            action("Dimensions-Multiple")
            {
                Caption = 'Dimensions-Multiple';
                AccessByPermission = TableData Dimension = R;
                Promoted = true;
                PromotedCategory = Category5;
                Image = DimensionSets;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GudfoodItem: Record "Gudfood Item";
                    DefaultDimensionsMultiple: Page "Default Dimensions-Multiple";
                begin
                    CurrPage.SetSelectionFilter(GudfoodItem);
                    DefaultDimensionsMultiple.SetMultiRecord(GudfoodItem, Rec.FieldNo(Code));
                    DefaultDimensionsMultiple.RunModal();
                end;
            }
        }
    }

}