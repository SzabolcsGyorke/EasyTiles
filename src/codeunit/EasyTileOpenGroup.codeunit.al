codeunit 80101 "Easy Tile Open Group"
{

    SingleInstance = true;


    var
        EditMode: Boolean;
        PreviewMode: Boolean;
        TileGroupCode: Code[20];

    internal procedure Reset()
    begin
        TileGroupCode := '';
        PreviewMode := false;
        EditMode := false;
    end;

    internal procedure SetPreviewMode(NewTileGroupCode: Code[20])
    begin
        TileGroupCode := NewTileGroupCode;
        PreviewMode := true;
        EditMode := false;
    end;

    internal procedure SetEditMode(NewTileGroupCode: Code[20])
    begin
        TileGroupCode := NewTileGroupCode;
        PreviewMode := false;
        EditMode := true;
    end;

    internal procedure GetPreviewMode(): Boolean
    begin
        exit(PreviewMode);
    end;

    internal procedure GetEditMode(): Boolean
    begin
        exit(EditMode);
    end;

    internal procedure GetTileGroupCode(): Code[20]
    begin
        exit(TileGroupCode);
    end;
}
