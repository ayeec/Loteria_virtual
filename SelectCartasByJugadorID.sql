SELECT c.intcvecarta, c.vchnombre, c.rutaimagen, c.vchtexto, cdj.intIDpeso
            FROM cartas c JOIN cartascategoria cc ON c.intcvecarta = cc.intcvecarta
            JOIN categoria cat ON cat.intidcategoria = cc.intidcategoria
            JOIN categoriasdejugador cdj ON cdj.intidcategoria = cat.intidcategoria
            WHERE cdj.intcvejugador = 2