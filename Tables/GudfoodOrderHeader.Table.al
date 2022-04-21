table 50101 "Gudfood Order Header"
{
    Caption = 'Gudfood Order Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    SalesReceivablesSetup.GET;
                    NoSeriesManagement.TestManual(SalesReceivablesSetup."Gudfood Order Nos.");
                    "No. Series" := '';
                    NoSeriesManagement.SetSeries("No.");
                end;

                CreateDim(Database::"Gudfood Item", "No.",
                          Database::Customer, "No.");
            end;
        }
        field(2; "Sell- to Customer No."; Code[20])
        {
            Caption = 'Sell- to Customer No.';
            TableRelation = Customer."No.";
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

                CreateDim(Database::"Gudfood Item", "No.",
                          Database::Customer, "Sell- to Customer No.");
            end;
        }
        field(3; "Sell- to Customer Name"; Text[100])
        {
            Caption = 'Sell- to Customer Name';
            FieldClass = Normal;
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
            CalcFormula = Sum("Gudfood Order Line".Quantity WHERE("Order No." = FIELD("No.")));
            Editable = false;
        }
        field(6; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Gudfood Order Line".Amount WHERE("Order No." = FIELD("No.")));
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

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(10; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Date Created" := WorkDate();

        if "No." = '' then begin
            SalesReceivablesSetup.Get();
            SalesReceivablesSetup.TestField("Gudfood Order Nos.");
            NoSeriesManagement.InitSeries(SalesReceivablesSetup."Gudfood Order Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;

    end;

    trigger OnDelete()
    begin
        GudfoodOrderLine.SetRange("Order No.", "No.");
        GudfoodOrderLine.DeleteAll();
        ;
    end;

    local procedure GudfoodLinesExist(): Boolean
    begin
        GudfoodOrderLine.RESET;
        GudfoodOrderLine.SETRANGE("Order No.", "No.");
        EXIT(GudfoodOrderLine.FINDFIRST);
    end;

    local procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[2] of Integer;
        No: array[2] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
        DimMgt.GetDefaultDimID(TableID, No,
        SourceCodeSetup.Sales,
        "Shortcut Dimension 1 Code",
        "Shortcut Dimension 2 Code", 0, 0);

        IF (OldDimSetID <> "Dimension Set ID") AND
            GudfoodLinesExist
            then begin
            Modify;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(
        FieldNumber,
        ShortcutDimCode,
        "Dimension Set ID");
        if "No." <> '' then
            Modify();
        IF OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if GudfoodLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    internal procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
        DimMgt.EditDimensionSet(
        "Dimension Set ID", "No.",
        "Shortcut Dimension 1 Code",
        "Shortcut Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if GudfoodLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm(ChngDimMsg) then
            exit;
        GudfoodOrderLine.Reset();
        GudfoodOrderLine.SetRange("Order No.", "No.");
        GudfoodOrderLine.LockTable();
        if GudfoodOrderLine.Find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(GudfoodOrderLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if GudfoodOrderLine."Dimension Set ID" <> NewDimSetID then begin
                    GudfoodOrderLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                    GudfoodOrderLine."Dimension Set ID",
                    GudfoodOrderLine."Shortcut Dimension 1 Code",
                    GudfoodOrderLine."Shortcut Dimension 2 Code");
                    GudfoodOrderLine.Modify();
                end;
            until GudfoodOrderLine.Next() = 0;
    end;

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        DimMgt: Codeunit DimensionManagement;
        GudfoodOrderLine: Record "Gudfood Order Line";
        ChngDimMsg: Label 'You may have changed a dimension.\\Do you want to update the lines?';

}