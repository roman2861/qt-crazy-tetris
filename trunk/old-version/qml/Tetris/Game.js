.pragma library

function SetupGame()
{
    console.log("Setup Game");
}

function Run()
{
    UpdateGame();
    PaintGame();
}

function InputHandle(input)
{
    console.log("input handle with: " + input);
}

function UpdateGame()
{
    console.log("Update");
}

function PaintGame()
{
    console.log("Paint");
}
