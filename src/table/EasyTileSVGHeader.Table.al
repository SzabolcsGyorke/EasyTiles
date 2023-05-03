table 80104 "Easy Tile SVG Header"
{
    Caption = 'Easy Tile SVG Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Default"; Boolean)
        {
            Caption = 'Default';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                EasyTileSVGHeader: Record "Easy Tile SVG Header";
                ReplaceDefaultQst: Label 'The SVG Header %1 already marked as defult.\Do you want to replace it?', Comment = '%1 exisitng default code';
            begin
                if Default then begin
                    EasyTileSVGHeader.SetFilter(Code, '<>%1', Code);
                    EasyTileSVGHeader.SetRange(Default, true);
                    if EasyTileSVGHeader.FindFirst() then
                        if Confirm(ReplaceDefaultQst, false, EasyTileSVGHeader.Code) then begin
                            EasyTileSVGHeader.Default := false;
                            EasyTileSVGHeader.Modify(true);
                        end else
                            Default := false;
                end;
            end;
        }
        field(4; "Width"; Text[250])
        {
            Caption = 'Width';
            DataClassification = CustomerContent;

        }
        field(5; "Height"; Text[250])
        {
            Caption = 'Height';
            DataClassification = CustomerContent;

        }
        field(9; Definition; Text[1024])
        {
            Caption = 'Misc. Definition';
            DataClassification = CustomerContent;
        }

        field(10; "Import SVG"; Blob)
        {
            Caption = 'Import SVG';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }

        field(11; "Image"; Media)
        {
            Caption = 'Image';
            DataClassification = CustomerContent;
            ExtendedDatatype = Person;
            Description = 'only used for store the preview for the tile view';
        }
        field(12; "Assigned to Tiles"; Integer)
        {
            Caption = 'Assigned to Tiles';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Easy Tile Group Line" where("Icon SVG Code" = field(Code)));
        }


    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {
        }
        fieldgroup(Brick; code, Description, Image)
        {
        }
    }

    internal procedure GetImportSVG(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Import SVG");
        "Import SVG".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Import SVG")));
    end;

    internal procedure SetImportSVG(NewImportSVG: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Import SVG");
        "Import SVG".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewImportSVG);
        Modify();
    end;


    trigger OnDelete()
    var
        EasyTileSVGLine: Record "Easy Tile SVG Line";
        EasyTileSVGMainStyleLine: Record "Easy Tile SVG Main Style Line";
    begin
        EasyTileSVGLine.SetRange("SVG Header Code", Code);
        EasyTileSVGLine.DeleteAll();

        EasyTileSVGMainStyleLine.SetRange("SVG Header Code", Code);
        EasyTileSVGMainStyleLine.DeleteAll();
    end;
}
