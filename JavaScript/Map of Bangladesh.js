/*
 * Fun Purpose only.
 * Does Simply Nothing but prints Bangladesh's map on terminal
 * Runs only on NodeJS
 * Ported from Sister-in-Law(https://www.facebook.com/cordelia.seu)('s) C Code
 */


var str = "ED//GDAD//DLEB//COCC//CV//FS//HQ//JN//MP//Go//Cr//Cq//Cp//Fk//Jf//J`//I`//H`ID//J^HE//K^FG//N[ABCG//L`CG//MTBT//MUCS//NTDBCBAJ//NUBBHI//OTMI//OROI//OGDCSI//PE[I//RC[I//rBDB//rB//sB//tB";
var c, i, j, k = 1;

for (i = 0; i < str.length; i++) {
    c = str[i].charCodeAt() - 64;
    if(str[i].charCodeAt() === 47){
        console.log();
        ++i;
    }
    else if(i % 2 == 0) {
        while(c != 0) {
            process.stdout.write(' ');
            c--;
        }
    }
    else {
        while(c != 0) {
            process.stdout.write('|');
            c--;
        }
    }
}

console.log();
