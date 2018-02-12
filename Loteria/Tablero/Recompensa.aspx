<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Recompensa.aspx.cs" Inherits="Tablero_Recompensa" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            color: #CC0000;
        }
        html,body{
	        padding: 0;
	        margin: 0;
	        height: 100%;
	        width: 100%;
	        background-color: black;
	        overflow: hidden;
        }
        #cnv{
	        overflow: hidden;
        }
        #mainContent{
            position: absolute; 
            z-index: 1; 
            left: 50px; 
            top: 20px; 
            width:100px; 
            height:20px;
        }
        .auto-style3 {
            color: #FFFFFF;
        }
    </style>
    
</head>
<body>
    <script src="../Scripts/Confetti.js"></script>
    <div width="50%">
<canvas id="cnv">
</canvas>
        <canvas id="cnv"></canvas>
<input type="button" value="reset" id="reset" />
</div>
    <form id="form1" runat="server">
        <div class="auto-style1" id="mainContent">
            <h1><span class="auto-style2">Felicidades</span></h1>
            <h2>
                <span class="auto-style3"><%= Request.QueryString["correct"] %> imagenes correcta(s)</span>
            </h2>
            <h3>
                <span class="auto-style3">Calificación <%= String.Format("{0:0.0}", Double.Parse(Request.QueryString["correct"])/Double.Parse(Request.QueryString["total"])*10) %></span>
            </h3>
        </div>
    </form>
    <script language="JavaScript">
        /*Confetti code from https://codepen.io/usrfrndly/pen/xtyEc adapted to this application*/
        var cnv = document.getElementById("cnv");
        var context = cnv.getContext("2d");
        cnv.width = window.innerWidth;
        cnv.height = window.innerHeight;

        var atoms = [];
        var natoms = 250;
        var atomspeed = 1.7;
        function atom(x, y, rx, ry) {
            this.x = x;
            this.y = y;
            this.sx = 0;
            this.sy = 0;
            this.rx = rx;
            this.ry = ry;
            this.color = { r: 0, g: 0, b: 0 };
            this.draw = function (context) {
                context.beginPath();
                context.fillStyle = "rgba(" + this.color.r + "," + this.color.g + "," + this.color.b + ",0.6)";
                context.arc(this.x + 3, this.y + 3, this.rx, 0, 2 * Math.PI);
                context.fill();
            }
        }

        function update() {
            for (var i = 0; i < natoms; i++) {
                atoms[i].x += atoms[i].sx;
                atoms[i].y += atoms[i].sy;
                if (atoms[i].x > cnv.width)
                    atoms[i].x = 0;
                else if (atoms[i].x < 0)
                    atoms[i].x = cnv.width;
                if (atoms[i].y > cnv.height)
                    atoms[i].y = 0;
                else if (atoms[i].y < 0) //never happens but check anyway
                    atoms[i].y = cnv.height;
            };
        }

        function render() {
            context.clearRect(0, 0, cnv.width, cnv.height);
            for (var i = 0; i < natoms; i++) {
                atoms[i].draw(context);
            };
        }

        function loop() {
            update();
            render();
            requestAnimationFrame(loop, cnv);
        };

        function initialize() {
            for (var i = 0; i < natoms; i++) {
                var t = new atom(Math.random() * cnv.width, Math.random() * cnv.height, 1 + Math.random() * 5, 1 + Math.random() * 5);
                t.sx = Math.random() * atomspeed * 2 - atomspeed;
                t.sy = Math.random() * atomspeed + atomspeed;
                t.color = {
                    r: parseInt(Math.random() * 70 + 120),
                    g: parseInt(Math.random() * 70 + 120),
                    b: parseInt(Math.random() * 70 + 120)
                }
                atoms[i] = t;
            };
        }
        document.getElementById("reset").onclick = function () {
            if (confirm('¿Desea terminar?')) {
                initialize();
                loop();
                document.getElementById("reset").disabled = true;
            }
        }

        function main() {
            initialize();
            loop();
        }

main();
</script>
</body>
</html>
