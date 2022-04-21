table 50104 "Posted Gudfood Order Line"
{
    Caption = 'Posted Gudfood Order Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(3; "Sell- to Custo mer No."; Code[20])
        {
            Caption = 'Sell- to Custo mer No.';
            TableRelation = "Gudfood Order Header"."Sell- to Customer No.";
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = "Gudfood Item";
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                GudfoodIten: Record "Gudfood Item";
            begin
                if GudfoodIten."Shelf Life" < WorkDate then
                    Error('Expired Shelf Life');
            end;
        }
        field(6; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionMembers = " ",Salat,Burger,Capcake,Drink;
            OptionCaption = ' ,Salat,Burger,Capcake,Drink';
            FieldClass = FlowField;
            CalcFormula = Lookup("Gudfood Item".Type WHERE(Code = FIELD("Item No.")));
            Editable = false;
        }
        field(7; "Description"; Text[100])
        {
            Caption = 'Description';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(8; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            MinValue = 0;
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Quantity < 0 then
                    Error('Number Cannot Be Less Than Zero');
                Amount := Quantity * "Unit Price";
            end;
        }
        field(9; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            TableRelation = "Gudfood Item"."Unit Price";
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Price";
                IF Quantity < 0 THEN
                    ERROR('Number Cannot Be Less Than Zero');
            end;
        }
        field(10; "Amount"; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = const(false));
            DataClassification = ToBeClassified;
        }
        field(13; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }
}