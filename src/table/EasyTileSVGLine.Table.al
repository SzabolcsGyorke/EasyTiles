table 80105 "Easy Tile SVG Line"
{
    Caption = 'Easy Tile SVG Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SVG Header Code"; Code[100])
        {
            Caption = 'SVG Header Code';
            DataClassification = CustomerContent;
            TableRelation = "Easy Tile SVG Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Shape Type"; Enum "Easy Tile SVG Shape")
        {
            Caption = 'Shape Type';
            DataClassification = CustomerContent;
        }
        field(4; Parameters; Text[2048])
        {
            Caption = 'Parameters';
            DataClassification = CustomerContent;
        }
        field(5; Class; Text[250])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
        }
        field(6; Style; Text[250])
        {
            Caption = 'Additional Style';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                styleelements: List of [Text];
                styleelement: Text;
                attrandfield: List of [Text];
                attribute: Text;
                value: Text;
                remainingstyle: Text;
            begin
                //explode style to dedicated fields
                if Style <> '' then begin
                    styleelements := Style.Split(';');
                    if styleelements.Count > 0 then begin
                        foreach styleelement in styleelements do begin
                            attrandfield := styleelement.Split(':');
                            if attrandfield.Count > 0 then begin
                                attribute := attrandfield.Get(1);
                                value := attrandfield.Get(2);
                                case attribute of
                                    'fill':
                                        Rec.fill := value;
                                    'stroke':
                                        Rec.stroke := value;
                                    'stroke-linecap':
                                        Rec."stroke-linecap" := value;
                                    'stroke-miterlimit':
                                        Rec."stroke-miterlimit" := value;
                                    'stroke-width':
                                        Rec."stroke-width" := value;
                                    else
                                        remainingstyle += StrSubstNo('%1:%2;', attribute, value);
                                end;
                            end;
                        end;
                        if StrLen(remainingstyle) > 0 then
                            if remainingstyle[StrLen(remainingstyle)] = ';' then
                                remainingstyle := CopyStr(remainingstyle, 1, StrLen(remainingstyle) - 1);
                    end else begin
                        remainingstyle := Style;
                    end;
                end;
                Style := remainingstyle;
            end;
        }
        field(7; "Manual Line"; Text[1024])
        {
            Caption = 'Manual Line';
            DataClassification = CustomerContent;
        }
        field(8; "Protected Style"; Boolean)
        {
            Caption = 'Protected Style';
            DataClassification = CustomerContent;
        }

        field(10; "fill"; Text[50])
        {
            Caption = 'fill';
            DataClassification = CustomerContent;
        }
        field(11; "stroke"; Text[50])
        {
            Caption = 'stroke';
            DataClassification = CustomerContent;
        }
        field(12; "stroke-linecap"; Text[50])
        {
            Caption = 'stroke-linecap';
            DataClassification = CustomerContent;
        }
        field(13; "stroke-miterlimit"; Text[50])
        {
            Caption = 'stroke-miterlimit';
            DataClassification = CustomerContent;
        }
        field(14; "stroke-width"; Text[50])
        {
            Caption = 'stroke-width';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "SVG Header Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
