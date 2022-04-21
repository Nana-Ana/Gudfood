table 50102 "Gudfood Order Line"
{
    Caption = 'Gudfood Order Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Sell- to Customer No."; Code[20])
        {
            Caption = 'Sell- to Customer No.';
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CreateDim(DATABASE::"Customer", "Sell- to Customer No.",
                          Database::"Gudfood Item", "Item No.");
            end;
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
            TableRelation = "Gudfood Item".Code;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                GudfoodIten: Record "Gudfood Item";
            begin
                if "Item No." <> '' then begin
                    GudfoodIten.Get("Item No.");
                    if GudfoodIten."Shelf Life" < Today then
                        Error('Expired Shelf Life');
                    "Unit Price" := GudfoodIten."Unit Price";
                    Description := GudfoodIten.Description;
                    CreateDim(DATABASE::"Customer", "Sell- to Customer No.",
                          Database::"Gudfood Item", "Item No.");
                end else begin
                    "Unit Price" := 0;
                    Description := '';
                end;
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
            DataClassification = ToBeClassified;
        }
        field(8; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            MinValue = 0;
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
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Price";
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

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = const(false));
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                ShowDimensions("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        GudfoodoOrderHeader.Get("Order No.");
        "Sell- to Customer No." := GudfoodoOrderHeader."Sell- to Customer No.";
        "Date Created" := GudfoodoOrderHeader."Date Created";
    end;

    procedure ShowDimensions(var "Dimension Set ID": Integer; var "Shortcut Dimension 1": Code[20]; var "Shortcut Dimension 2": Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', "Order No.", "Line No."), "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    local procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20])
    var
        TableID: array[2] of Integer;
        No: array[2] of Code[20];
        ShortcutDimension1Code: Code[20];
        ShortcutDimension2Code: Code[20];
        DimensionSetID: Integer;
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" := DimMgt.GetDefaultDimID(TableID, No, SourceCodeSetup.Sales,
        "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, DATABASE::"Gudfood Item");
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        DimensionSetID: Integer;
        OldDimSetId: Integer;
    begin
        OldDimSetId := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            Modify();
        end;
    end;

    var
        GudfoodoOrderHeader: Record "Gudfood Order Header";
        DimMgt: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
}