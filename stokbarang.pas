program stokbarang;
uses crt;
const nmax = 9999;
type barang = record kodebarang ,nama,exp : string;
                        hargasatu : longint;
                        jumlah : integer;
end;
type arrbarang = array [1..nmax] of barang;
var
    file_brg : file of barang;
    brg : barang;
    pil: integer;
    arr : arrbarang;

    procedure bikinfile;
    begin
        clrscr;
        assign(file_brg,'barang.dat');
        rewrite(file_brg);
        writeln(' _________________________________');
        writeln('|       file berhasil dibuat      |');
        writeln('|_________________________________|');
        readln;
        close(file_brg);
    end;

    procedure isidata;
    var
        i : integer;
        lagi : char;
    begin
        clrscr;
        assign(file_brg,'barang.dat');
        reset(file_brg);
        repeat
            inc(i);
            clrscr;
            writeln(' _________________________________');
            writeln('|        silahkan isi data        |');
            writeln('|_________________________________|');
            writeln;
            with brg do
            begin
                write('Nama Barang : '); readln(nama);
                write('masukan kode barang : ');    readln(kodebarang);
                write('masukan harga persatu barang : ');   readln(hargasatu);
                write('masukan jumlah barang : ');  readln(jumlah);
                write('tanggal kadaluarsa barang ex(dd/mm/yy) : ');    readln(exp);
            end;

                seek(file_brg, filesize(file_brg));
                write(file_brg,brg);
                writeln;
                write('Apakah anda ingin mengisi data lagi (Y/T)? : ');  readln(lagi);
        until not (lagi in ['Y','y']);
        close (file_brg);
    end;

    procedure cetakdata;
    var
        i : integer;
    begin
        clrscr;
        assign(file_brg,'barang.dat');
        reset(file_brg);
        i := 1;

        if(filesize(file_brg) = 0)then
            begin
            writeln(' _________________________________');
            writeln('|        Data Masih Kosong        |');
            writeln('|_________________________________|');
            end;

        while(not EOF(file_brg))do
        begin
            read(file_brg, brg);
            with brg do
            begin
                writeln;
                writeln(' _________________________________');
                writeln('|       Data barang ke- ',i,'         |');
                writeln('|_________________________________|');
                writeln;
                writeln('Nama Barang : ',nama);
                writeln('Kode Barang : ',kodebarang);
                writeln('Harga Persatu Barang : ',hargasatu);
                writeln('Jumlah barang : ',jumlah);
                writeln('Tanggal kadaluarsa barang : ',exp);
            end;
            inc(i);
        end;

        close(file_brg);
        readln;
    end;

   procedure caridata;
    var
        i : integer;
        cari : string;
        found : boolean;
    begin
        clrscr;
        assign(file_brg,'barang.dat');
        reset(file_brg);
        write('masukan kode yang akan di cari : ');  readln(cari);
        found := false;
        while (not EOF(file_brg)) do
            begin
                read(file_brg , brg);
                if brg.kodebarang = cari then
                    begin
                    with brg do
                        found:= true;
                        writeln;
                        writeln(' _________________________________');
                        writeln('|          Data ditemukan         |');
                        writeln('|_________________________________|');
                        writeln;
                        writeln('Nama Barang : ',brg.nama);
                        writeln('Kode Barang : ',brg.kodebarang);
                        writeln('Harga Persatu Barang : ',brg.hargasatu);
                        writeln('Jumlah barang : ',brg.jumlah);
                        writeln('Tanggal kadaluarsa barang : ',brg.exp);
                    end;
            end;
        if found = false then
        begin
            writeln;
            writeln(' _________________________________');
            writeln('|       Data tidak ditemukan      |');
            writeln('|_________________________________|');
        end;
        readln;
        close(file_brg);
    end;

    
    procedure ubahdata; 
    var 
        i : integer; 
        ubah : string; 
        found : boolean; 
        tmp : file of barang; 
        lagi : char;
 
    begin 
        clrscr; 
        assign(file_brg,'barang.dat'); 
        reset(file_brg); 
        assign(tmp,'hapus.dat'); 
        rewrite(tmp); 
        repeat
        clrscr;
        write('masukan kode barang yang akan di cari : '); readln(ubah); 
            found := false; 
            i:=0; 
            while (not EOF(file_brg)) do 
                begin 
                    read(file_brg , brg); 
                    if brg.kodebarang = ubah then 
                        begin 
 
                            found:= true; 
                            writeln; 
                            writeln(' _________________________________'); 
                            writeln('|          Data ditemukan         |'); 
                            writeln('|_________________________________|'); 
                            writeln; 
                            writeln('Nama Barang : ',brg.nama); 
                            writeln('Kode Barang : ',brg.kodebarang); 
                            writeln('Harga Persatu Barang : ',brg.hargasatu); 
                            writeln('Jumlah barang : ',brg.jumlah); 
                            writeln('Tanggal kadaluarsa barang : ',brg.exp); 
                            writeln; 
 
                            writeln('------------------------------------------');
 
                            writeln; 
                            writeln(' _________________________________'); 
                            writeln('|        silahkan ubah data       |'); 
                            writeln('|_________________________________|'); 
                            writeln; 
                            write('Nama Barang : '); readln(brg.nama); 
                            write('masukan kode barang : '); readln(brg.kodebarang); 
                            write('masukan harga persatu barang : '); readln(brg.hargasatu); 
                            write('masukan jumlah barang : '); readln(brg.jumlah); 
                            write('tanggal kadaluarsa barang ex("dd/mm/yy") : '); readln(brg.exp); 
                            write(tmp, brg); 
                        end 
                    else 
                    begin 
                        write(tmp, brg); 
                    end; 
                end; 
 
            if found = false then 
            begin 
                writeln; 
                writeln(' _________________________________'); 
                writeln('|      Data tidak ditemukan       |'); 
                writeln('|_________________________________|'); 
            end; 
            write('Apakah anda ingin mengubah data lagi (Y/T)?: ');    readln(lagi);
        until not (lagi in ['Y','y']); 
        close(file_brg); 
        erase(file_brg); 
        close(tmp); 
        rename(tmp,'barang.dat'); 
    end;
    procedure hapusdata;
    var
        i : integer;
        hapus : string;
        temp : file of barang;
        found : boolean;
    begin
        clrscr;
        assign(file_brg,'barang.dat');
        assign(temp,'hapus.dat');
        rewrite(temp);
        reset(file_brg);
        write('Cari kode barang yang akan di hapus : ');   readln(hapus);
        found := false;
        i := 0;
        while (not EOF(file_brg)) do
        begin
            read(file_brg , brg);
                if brg.kodebarang = hapus then 
                    begin 
                        found:= true; 
                        writeln; 
                        writeln(' _________________________________'); 
                        writeln('|          Data ditemukan         |'); 
                        writeln('|_________________________________|'); 
                        writeln; 
                        writeln('Nama Barang : ',brg.nama); 
                        writeln('Kode Barang : ',brg.kodebarang); 
                        writeln('Harga Persatu Barang : ',brg.hargasatu); 
                        writeln('Jumlah barang : ',brg.jumlah); 
                        writeln('Tanggal kadaluarsa barang : ',brg.exp); 
                        writeln; 
                    end;
            if brg.kodebarang <> hapus then
                begin
                    write(temp, brg);
                end
            else
            begin
                writeln; 
                writeln(' _______ __________________________'); 
                writeln('|       Data berhasil dihapus      |'); 
                writeln('|__________________________________|'); 
                writeln; 
            end;
        end;
        if found = false then
        begin
            writeln('data tidak ditemukan');
        end;
        readln;
        close(file_brg);
        erase(file_brg);
        close(temp);
        rename(temp,'barang.dat');
    end;

    procedure urutdata;
    var
        i ,k,j, min : integer;
        temp : barang;
    begin
        clrscr;
        assign(file_brg,'barang.dat');
        reset(file_brg);
         writeln(' ______________________________________________________');
         writeln('|       Hasil Pengurutan Berdasarakan Nama Barang      |');
         writeln('|______________________________________________________|');
         writeln;
        i := 1;
        while not EOF(file_brg) do
        begin
            read(file_brg,brg);
            arr[i] := brg;
            i := i + 1;
        end;
        close(file_brg);
        i:=i-1;

        for j := 1 to i-1 do
            begin
                min := j;
                for k := j + 1 to i do
                    if (arr[k].nama < arr[min].nama) then
                        min := k;

            temp := arr[min];
            arr[min] := arr[j];
            arr[j] := temp;
            end;

        for j := 1 to i do
            begin
                writeln;
                writeln(j +1,'. Nama Barang : ',arr[j].nama);
                writeln('  Kode Barang : ',arr[j].kodebarang);
                writeln('  Harga Persatu Barang : ',arr[j].hargasatu);
                writeln('  Jumlah barang : ',arr[j].jumlah);
                writeln('  Tanggal Kadaluarsa Barang : ',arr[j].exp);
            end;
        readln;
    end;

begin

    repeat
        clrscr;
        writeln('            _________________________________');
        writeln('           |       silahkan pilih menu       |');
        writeln('           |_________________________________|');
        writeln;
        writeln;
        writeln('            0. bikin file');
        writeln('            1. isi data');
        writeln('            2. tampilkan data');
        writeln('            3. cari data');
        writeln('            4. ubah data');
        writeln('            5. hapus data');
        writeln('            6. urut data');
        writeln('            7. keluar');
        writeln;
        write('Masukan Pilihan : ');    readln(pil);
        case pil of
          0 : bikinfile;
          1 : isidata;
          2 : cetakdata;
          3 : caridata;
          4 : ubahdata;
          5 : hapusdata;
          6 : urutdata;
          end;
    until (pil > 6);
end.