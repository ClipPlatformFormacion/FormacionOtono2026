namespace ClipPlatform.Training.MasterData;

enum 50100 "Edition Type"
{
    CaptionML = ENU = 'Edition Type', ESP = 'Tipo edición';
    Extensible = true;

    value(0; " ")
    {
        CaptionML = ENU = ' ', ESP = ' ';
    }
    value(1; "Instructor-Lead")
    {
        CaptionML = ENU = 'Instructor-Lead', ESP = 'Guiado por profesor';
    }
    value(2; "Video Tutorial")
    {
        CaptionML = ENU = 'Video Tutorial', ESP = 'Vídeo tutorial';
    }
}