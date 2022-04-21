table 50100 "Gudfood Item"
{
    Caption = 'Gudfood Item';
    TableType = Normal;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                NoSeriesManagement: Codeunit NoSeriesManagement;
                SalesReceivablesSetup: Record "Sales & Receivables Setup";
            begin
                IF Code <> xRec.Code then begin
                    SalesReceivablesSetup.GET;
                    NoSeriesManagement.TestManual(SalesReceivablesSetup."Gudfood Item Nos.");
                    "No. Series" := '';
                    NoSeriesManagement.SetSeries(Code);
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(4; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",Salat,Burger,Capcake,Drink;
            OptionCaption = ' ,Salat,Burger,Capcake,Drink';
            DataClassification = ToBeClassified;
        }
        field(5; "Qty. Ordered"; Decimal)
        {
            Caption = 'Qty. Ordered';
            FieldClass = FlowField;
            CalcFormula = Sum("Posted Gudfood Order Line".Quantity WHERE("Item No." = FIELD(Code)));
        }
        field(6; "Qty. in Order"; Decimal)
        {
            Caption = 'Qty. in Order';
            FieldClass = FlowField;
            CalcFormula = Sum("Gudfood Order Line".Quantity WHERE("Item No." = FIELD(Code)));
        }
        field(7; "Shelf Life"; Date)
        {
            Caption = 'Shelf Life';
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        IF Code = '' THEN BEGIN
            SalesReceivablesSetup.GET;
            SalesReceivablesSetup.TestField("Gudfood Item Nos.");
            NoSeriesManagement.InitSeries(SalesReceivablesSetup."Gudfood Item Nos.", xRec.Code, 0D, Code, "No. Series");
        END;
        DimMgt.UpdateDefaultDim(
        DATABASE::"Gudfood Item", Code,
        "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;

    trigger OnDelete()
    begin
        DimMgt.DeleteDefaultDim(Database::"Gudfood Item", Code);
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])

    begin

        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);

        if not IsTemporary then begin
            DimMgt.SaveDefaultDim(Database::"Gudfood Item", Code, FieldNumber, ShortcutDimCode);
            Modify();
        end;
    end;

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        DimMgt: Codeunit DimensionManagement;
}