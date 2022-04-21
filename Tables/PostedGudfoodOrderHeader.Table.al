table 50103 "Posted Gudfood Order Header"
{
    Caption = 'Posted Gudfood Order Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Sell- to Customer No."; Code[20])
        {
            Caption = 'Sell- to Customer No.';
            TableRelation = Customer;
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Customer: Record "Customer";
            begin
                if "Sell- to Customer No." <> '' then begin
                    Customer.Get("Sell- to Customer No.");
                    "Sell- to Customer Name" := Customer.Name;
                end else
                    "Sell- to Customer Name" := '';
            end;
        }
        field(3; "Sell- to Customer Name"; Text[100])
        {
            Caption = 'Sell- to Customer Name';
            FieldClass = Normal;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Total Qty."; Decimal)
        {
            Caption = 'Total Qty.';
            FieldClass = FlowField;
            CalcFormula = Sum("Posted Gudfood Order Line".Quantity WHERE("Order No." = FIELD("No.")));
            Editable = false;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Posted Gudfood Order Line".Amount WHERE("Order No." = FIELD("No.")));
            Editable = false;
        }

        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            DataClassification = ToBeClassified;

        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            DataClassification = ToBeClassified;

        }
        field(10; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = ToBeClassified;

        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}