codeunit 80102 "Easy Tile SVG Management"
{

    internal procedure CreateSVG(SVGCode: Code[100]; isPreview: Boolean) OtputSVG: Text;
    var
        EasyTileSVGHeader: Record "Easy Tile SVG Header";
    begin
        OtputSVG := '';
        if EasyTileSVGHeader.Get(SVGCode) then
            OtputSVG := CreateSVG(EasyTileSVGHeader, isPreview);
    end;

    internal procedure CreateSVG(EasyTileSVGHeader: Record "Easy Tile SVG Header"; isPreview: Boolean) OtputSVG: Text;
    begin
        if isPreview then
            OtputSVG := CreateSVG(EasyTileSVGHeader, '100', '100')
        else
            OtputSVG := CreateSVG(EasyTileSVGHeader, '', '');
    end;

    internal procedure CreateSVG(EasyTileSVGHeader: Record "Easy Tile SVG Header"; WidthOverwrite: Text; HeightOverwrite: Text) OtputSVG: Text;
    var
        EasyTileSVGLine: Record "Easy Tile SVG Line";
        EasyTileSVGMainStyleLine: Record "Easy Tile SVG Main Style Line";
        MainSvgLineTxt: Label '<svg %1 width="%2" height="%3">', Comment = '%1 main attributes, %2 width, %3 height', Locked = true;
        SvgLineTxt: Label '<%1 %2 fill="%3" stroke="%4" stroke-linecap="%5" stroke-width="%6" stroke-miterlimit="%7"  class="%8" style="%9"/>', Comment = '%1 - shape, %2 - definition, %3 - class, %4 - style', Locked = true;
        MainSvgLineEndTxt: Label '</svg>', Locked = true;
    begin
        if HeightOverwrite <> '' then
            EasyTileSVGHeader.Height := HeightOverwrite;

        if WidthOverwrite <> '' then
            EasyTileSVGHeader.Width := WidthOverwrite;

        OtputSVG := StrSubstNo(MainSvgLineTxt, EasyTileSVGHeader.Definition, EasyTileSVGHeader.Width, EasyTileSVGHeader.Height);
        EasyTileSVGMainStyleLine.SetRange("SVG Header Code", EasyTileSVGHeader.Code);
        EasyTileSVGMainStyleLine.SetFilter(Value, '<>%1', '');
        EasyTileSVGLine.SetRange("SVG Header Code", EasyTileSVGHeader.Code);
        if EasyTileSVGLine.FindSet() then
            repeat
                //overwrite origial style
                if not EasyTileSVGLine."Protected Style" then begin
                    //fill
                    EasyTileSVGMainStyleLine.SetRange("Attribute Type", EasyTileSVGMainStyleLine."Attribute Type"::fill);
                    if EasyTileSVGMainStyleLine.FindFirst() then
                        EasyTileSVGLine.fill := EasyTileSVGMainStyleLine.Value;
                    //stroke
                    EasyTileSVGMainStyleLine.SetRange("Attribute Type", EasyTileSVGMainStyleLine."Attribute Type"::stroke);
                    if EasyTileSVGMainStyleLine.FindFirst() then
                        EasyTileSVGLine.stroke := EasyTileSVGMainStyleLine.Value;
                    //stroke-linecap
                    EasyTileSVGMainStyleLine.SetRange("Attribute Type", EasyTileSVGMainStyleLine."Attribute Type"::"stroke-linecap");
                    if EasyTileSVGMainStyleLine.FindFirst() then
                        EasyTileSVGLine."stroke-linecap" := EasyTileSVGMainStyleLine.Value;
                    //stroke-width
                    EasyTileSVGMainStyleLine.SetRange("Attribute Type", EasyTileSVGMainStyleLine."Attribute Type"::"stroke-width");
                    if EasyTileSVGMainStyleLine.FindFirst() then
                        EasyTileSVGLine."stroke-width" := EasyTileSVGMainStyleLine.Value;
                    //stroke-miterlimit
                    EasyTileSVGMainStyleLine.SetRange("Attribute Type", EasyTileSVGMainStyleLine."Attribute Type"::"stroke-miterlimit");
                    if EasyTileSVGMainStyleLine.FindFirst() then
                        EasyTileSVGLine."stroke-miterlimit" := EasyTileSVGMainStyleLine.Value;
                    //TODO: Manual
                end;

                OtputSVG += StrSubstNo(SvgLineTxt, EasyTileSVGLine."Shape Type", EasyTileSVGLine.Parameters, EasyTileSVGLine.fill, EasyTileSVGLine.stroke, EasyTileSVGLine."stroke-linecap", EasyTileSVGLine."stroke-width", EasyTileSVGLine."stroke-miterlimit", EasyTileSVGLine.Class, EasyTileSVGLine.Style);
            until EasyTileSVGLine.Next() < 1;

        OtputSVG += MainSvgLineEndTxt;
    end;

    internal procedure ChangeAttrValue(definition: text; attribute: text; replacevalue: Text; fieldassign: text; fieldstartdelimiter: text; fieldenddelimiter: text) retdefinition: Text
    var
        startpos: Integer;
        addtendpos: Integer;
        secondpart: Text;
        firstpart: Text;
    begin
        if StrPos(definition, attribute) > 0 then begin
            startpos := StrPos(definition, attribute) + StrLen(attribute) + StrLen(fieldassign);// + StrLen(fielddelimiter);
            firstpart := CopyStr(definition, 1, startpos - 1);
            secondpart := CopyStr(definition, startpos + strlen(fieldstartdelimiter), StrLen(definition));

            addtendpos := StrPos(secondpart, fieldenddelimiter);
            if addtendpos > 0 then
                retdefinition := firstpart + fieldstartdelimiter + replacevalue + fieldenddelimiter + Copystr(secondpart, addtendpos + strlen(fieldenddelimiter), strlen(secondpart))
            else
                retdefinition := firstpart + fieldstartdelimiter + replacevalue;
        end else
            retdefinition := definition;
    end;


    internal procedure ReadSVG(var EasyTileSVGHeader: Record "Easy Tile SVG Header"): Boolean;
    var
        EasyTileSVGLine: Record "Easy Tile SVG Line";
        XMLBufferWriter: Codeunit "XML Buffer Writer";
        XMLBufferReader: Codeunit "XML Buffer Reader";
        XMLBuffer: Record "XML Buffer" temporary;
        XMLBufferAttr: Record "XML Buffer" temporary;
        NextLineNo: Integer;
        svgtext: Text;
    begin
        svgtext := EasyTileSVGHeader."Import SVG";
        NextLineNo := 10000;
        if svgtext = '' then exit;

        XMLBufferWriter.InitializeXMLBufferFromText(XMLBuffer, svgtext);
        //page.Runmodal(Page::"XML Buffer ET", XMLBuffer);

        XMLBufferAttr.Copy(XMLBuffer, true);

        XMLBuffer.SetRange(Type, XMLBuffer.Type::Element);
        XMLBufferAttr.SetRange(Type, XMLBuffer.Type::Attribute);
        if XMLBuffer.FindSet() then
            repeat
                XMLBufferAttr.SetRange("Parent Entry No.", XMLBuffer."Entry No.");
                if XMLBuffer.Name <> 'svg' then begin
                    EasyTileSVGLine.Init();
                    EasyTileSVGLine."SVG Header Code" := EasyTileSVGHeader.Code;
                    EasyTileSVGLine."Line No." := NextLineNo;
                    EasyTileSVGLine.Insert(true);
                    NextLineNo += 10000;
                    EasyTileSVGLine."Shape Type" := Enum::"Easy Tile SVG Shape".Ordinals.Get(Enum::"Easy Tile SVG Shape".Names.IndexOf(XMLBuffer.Name)); //TODO: error handling if the first element after svg is not a brush type
                    EasyTileSVGLine.Modify(true);
                end;
                if XMLBufferAttr.FindSet() then
                    repeat
                        if XMLBuffer.Name = 'svg' then begin //header info
                            case XMLBufferAttr.Name of
                                'width':
                                    EasyTileSVGHeader.width := XMLBufferAttr.Value;
                                'height':
                                    EasyTileSVGHeader.Height := XMLBufferAttr.Value;
                                else
                                    EasyTileSVGHeader.Definition += StrSubstNo('%1="%2" ', XMLBufferAttr.Name, XMLBufferAttr.Value);
                            end;
                        end else begin //lines
                            case XMLBufferAttr.Name of
                                'fill':
                                    EasyTileSVGLine.fill := XMLBufferAttr.Value;
                                'stroke':
                                    EasyTileSVGLine.stroke := XMLBufferAttr.Value;
                                'stroke-miterlimit':
                                    EasyTileSVGLine."stroke-miterlimit" := XMLBufferAttr.Value;
                                'stroke-width':
                                    EasyTileSVGLine."stroke-width" := XMLBufferAttr.Value;
                                'stroke-linecap':
                                    EasyTileSVGLine."stroke-linecap" := XMLBufferAttr.Value;
                                'style':
                                    EasyTileSVGLine.Validate(Style, XMLBufferAttr.Value);
                                else
                                    EasyTileSVGLine.Parameters += StrSubstNo('%1="%2" ', XMLBufferAttr.Name, XMLBufferAttr."Long Value ET");
                            end;
                            EasyTileSVGLine.Modify();
                        end;
                    until XMLBufferAttr.Next() < 1;
            until XMLBuffer.Next() < 1;
        EasyTileSVGHeader.Modify();

        EasyTileSVGHeader.Modify(true);
        exit(true);
    end;

    internal procedure ApplyMainStyle(EasyTileSVGHeader: Record "Easy Tile SVG Header")
    var
        DefEasyTileSVGHeader: Record "Easy Tile SVG Header";
        DefEasyTileSVGMainStyleLine: Record "Easy Tile SVG Main Style Line";
        EasyTileSVGLine: Record "Easy Tile SVG Line";
        EasyTileSVGMainStyleLine: Record "Easy Tile SVG Main Style Line";
    begin
        DefEasyTileSVGHeader.SetRange(Default, true);
        if DefEasyTileSVGHeader.FindFirst() then begin
            DefEasyTileSVGMainStyleLine.SetRange("SVG Header Code", DefEasyTileSVGHeader.Code);
            if DefEasyTileSVGMainStyleLine.IsEmpty() then exit;

            if DefEasyTileSVGMainStyleLine.FindSet() then begin
                EasyTileSVGMainStyleLine.SetRange("SVG Header Code", EasyTileSVGHeader.Code);
                EasyTileSVGMainStyleLine.DeleteAll();
                repeat
                    EasyTileSVGMainStyleLine.Init();
                    EasyTileSVGMainStyleLine := DefEasyTileSVGMainStyleLine;
                    EasyTileSVGMainStyleLine."SVG Header Code" := EasyTileSVGHeader.Code;
                    EasyTileSVGMainStyleLine.Insert();
                until DefEasyTileSVGMainStyleLine.Next() < 1;
            end;
        end;
    end;

    internal procedure GetIonicIcons()
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonToken: JsonToken;
        JsonTextReaderWriter: Codeunit "Json Text Reader/Writer";
        JsonBuffer: Record "JSON Buffer" temporary;
        JsonBufferIcons: Record "JSON Buffer" temporary;
        jsondata: Label 'https://raw.githubusercontent.com/ionic-team/ionicons/main/src/data.json', Locked = true;
        httpcontent: Text;
        TempEasyTileSVGTag: Record "Easy Tile SVG Tag" temporary;
        TempImport: Record "Easy Tile SVG Tag" temporary;
        EasyTileSVGHeader: Record "Easy Tile SVG Header";
    begin
        if HttpClient.Get(jsondata, HttpResponseMessage) then begin
            HttpResponseMessage.Content.ReadAs(httpcontent);
            JsonTextReaderWriter.ReadJSonToJSonBuffer(httpcontent, JsonBuffer);
        end;

        //Page.RunModal(Page::"JSON Buffer ET", JsonBuffer);

        //get tags first
        JsonBuffer.SetRange(Depth, 4);
        JsonBuffer.SetFilter(Path, 'icons[*].tags[*]');
        JsonBuffer.SetRange("Token type", JsonBuffer."Token type"::String);

        if JsonBuffer.FindSet() then
            repeat
                if not TempEasyTileSVGTag.Get(UpperCase(JsonBuffer.Value)) then begin

                    TempEasyTileSVGTag.Init();
                    TempEasyTileSVGTag.Code := UpperCase(JsonBuffer.Value);
                    TempEasyTileSVGTag.Description := JsonBuffer.Value;
                    TempEasyTileSVGTag.Insert();
                end;

            until JsonBuffer.Next() < 1;


        Page.RunModal(Page::"Easy Tile SVG Tag Selector", TempEasyTileSVGTag);
        TempEasyTileSVGTag.SetRange(Selected, true);
        if TempEasyTileSVGTag.Count > 0 then begin
            JsonBufferIcons.Copy(JsonBuffer, true);
            JsonBuffer.Reset();

            if TempEasyTileSVGTag.FindSet() then
                repeat
                    JsonBuffer.SetRange(Depth, 4);
                    JsonBuffer.SetFilter(Path, 'icons[*].tags[*]');
                    JsonBuffer.SetRange("Token type", JsonBuffer."Token type"::String);
                    JsonBuffer.SetRange(Value, TempEasyTileSVGTag.Description);
                    if JsonBuffer.FindSet() then
                        repeat
                            JsonBufferIcons.SetRange(Depth, 3);
                            JsonBufferIcons.SetFilter(Path, 'icons[*].name');
                            JsonBufferIcons.SetRange("Token type", JsonBuffer."Token type"::String);
                            JsonBufferIcons.SetFilter("Entry No.", '..%1', JsonBuffer."Entry No.");
                            JsonBufferIcons.findlast();
                            if not TempImport.Get(UpperCase(JsonBufferIcons.Value)) then begin
                                TempImport.Init();
                                TempImport.Code := UpperCase(JsonBufferIcons.Value);
                                TempImport.Description := StrSubstNo('https://raw.githubusercontent.com/ionic-team/ionicons/main/src/svg/%1.svg', JsonBufferIcons.Value);
                                TempImport.Insert();
                            end;
                        until JsonBuffer.Next() < 1;
                until TempEasyTileSVGTag.Next() < 1;
        end;

        if TempImport.FindSet() then
            repeat
                if not EasyTileSVGHeader.Get(TempImport.Code) then begin
                    EasyTileSVGHeader.Init();
                    EasyTileSVGHeader.Code := TempImport.Code;
                    EasyTileSVGHeader.Description := TempImport.Code;
                    EasyTileSVGHeader.Insert(true);
                    Clear(HttpClient);
                    Clear(HttpResponseMessage);
                    if HttpClient.Get(TempImport.Description, HttpResponseMessage) then begin
                        HttpResponseMessage.Content.ReadAs(httpcontent);
                        if StrLen(httpcontent) < MaxStrLen(EasyTileSVGHeader."Import SVG") then
                            EasyTileSVGHeader."Import SVG" := httpcontent;
                        EasyTileSVGHeader.Modify(true);
                        Commit(); //:(
                        if not ReadSVG(EasyTileSVGHeader) then begin
                            EasyTileSVGHeader.Description := 'SVG Import error';
                            EasyTileSVGHeader.Modify(true);
                        end;
                        ApplyMainStyle(EasyTileSVGHeader);
                    end;
                end;
            until TempImport.Next() < 1;
    end;

    //to fixup the xml buffer value 250 characters limit
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"XML Buffer Writer", 'OnBeforeCanPassValue', '', true, true)]
    local procedure RelaxValueLengthCheck(Name: Text; var Value: Text; var ReturnValue: Boolean; var IsHandled: Boolean)
    var
        XMLBuffer: Record "XML Buffer";
    begin
        if StrLen(Value) > MaxStrLen(XMLBuffer.Value) then begin
            IsHandled := true;
            ReturnValue := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"XML Buffer Writer", 'OnBeforeInsertAttribute', '', true, true)]
    local procedure InsertAttributExtended(NodeDepth: Integer; NodeNumber: Integer; ParentXMLBuffer: Record "XML Buffer"; var AttributeName: Text; var AttributeValue: Text; var IsHandled: Boolean; var XMLBuffer: Record "XML Buffer")
    begin

        XMLBuffer.Reset();
        if XMLBuffer.FindLast() then;
        XMLBuffer.Init();
        XMLBuffer."Entry No." += 1;
        XMLBuffer."Parent Entry No." := ParentXMLBuffer."Entry No.";
        XMLBuffer.Path := CopyStr(ParentXMLBuffer.Path + '/@' + AttributeName, 1, MaxStrLen(XMLBuffer.Path));
        XMLBuffer."Node Number" := NodeNumber;
        XMLBuffer.Name := AttributeName;
        XMLBuffer.Value := CopyStr(AttributeValue, 1, MaxStrLen(XMLBuffer.Value));
        XMLBuffer."Long Value Used ET" := StrLen(AttributeValue) > MaxStrLen(XMLBuffer.Value);
        XMLBuffer."Long Value ET" := CopyStr(AttributeValue, 1, MaxStrLen(XMLBuffer."Long Value ET"));
        XMLBuffer.Depth := NodeDepth;
        XMLBuffer."Data Type" := GetType(XMLBuffer.Value);
        XMLBuffer.Type := XMLBuffer.Type::Attribute;
        XMLBuffer."Import ID" := ParentXMLBuffer."Import ID";

        XMLBuffer.Insert();

        IsHandled := true;
    end;

    local procedure GetType(Value: Text): Integer
    var
        DummyXMLBuffer: Record "XML Buffer";
        Decimal: Decimal;
    begin
        if Value = '' then
            exit(DummyXMLBuffer."Data Type"::Text);

        if Evaluate(Decimal, Value) then
            exit(DummyXMLBuffer."Data Type"::Decimal);

        exit(DummyXMLBuffer."Data Type"::Text)
    end;
}
