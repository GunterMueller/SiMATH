include ../../Makefile.flags


all: \
	calc_isint.o \
	calc_mvprod.o \
	calc_prod.o \
	calc_smul.o \
	ecqnftoeci_o.o \
	expover.o \
	gfrffact.o \
	gfsalgenies.o \
	gftyper.o \
	inprog.o \
	kenntest.o \
	magftyper.o \
	mamodtyper.o \
	manftyper.o \
	matrkenn.o \
	matrtyper.o \
	mistake.o \
	mlist.o \
	modtyper.o \
	nfeltoqnfel.o \
	nftocs.o \
	nftoqnf.o \
	nftyper.o \
	pctopflip.o \
	pfltopiip.o \
	pnftopcs.o \
	pnftoprip.o \
	prtopica.o \
	qnfeltonfel.o \
	qnftonf.o \
	smgftyper.o \
	smmodtyper.o \
	smnftyper.o \
	smtyper.o \
	svgftyper.o \
	svmodtyper.o \
	svnftyper.o \
	svtyper.o \
	togftyper.o \
	tonftyper.o \
	typer.o \
	vecgftyper.o \
	veckenn.o \
	vecmodtyper.o \
	vecnftyper.o \
	vlist.o \
	vmgftyper.o \
	vmmodtyper.o \
	vmnftyper.o \
	vmtyper.o \
	vtyper.o \
	ranlib


clean:
	rm -f *~
	rm -f calc_isint.o
	rm -f calc_mvprod.o
	rm -f calc_prod.o
	rm -f calc_smul.o
	rm -f ecqnftoeci_o.o
	rm -f expover.o
	rm -f gfrffact.o
	rm -f gfsalgenies.o
	rm -f gftyper.o
	rm -f inprog.o
	rm -f kenntest.o
	rm -f magftyper.o
	rm -f mamodtyper.o
	rm -f manftyper.o
	rm -f matrkenn.o
	rm -f matrtyper.o
	rm -f mistake.o
	rm -f mlist.o
	rm -f modtyper.o
	rm -f nfeltoqnfel.o
	rm -f nftocs.o
	rm -f nftoqnf.o
	rm -f nftyper.o
	rm -f pctopflip.o
	rm -f pfltopiip.o
	rm -f pnftopcs.o
	rm -f pnftoprip.o
	rm -f prtopica.o
	rm -f qnfeltonfel.o
	rm -f qnftonf.o
	rm -f smgftyper.o
	rm -f smmodtyper.o
	rm -f smnftyper.o
	rm -f smtyper.o
	rm -f svgftyper.o
	rm -f svmodtyper.o
	rm -f svnftyper.o
	rm -f svtyper.o
	rm -f togftyper.o
	rm -f tonftyper.o
	rm -f typer.o
	rm -f vecgftyper.o
	rm -f veckenn.o
	rm -f vecmodtyper.o
	rm -f vecnftyper.o
	rm -f vlist.o
	rm -f vmgftyper.o
	rm -f vmmodtyper.o
	rm -f vmnftyper.o
	rm -f vmtyper.o
	rm -f vtyper.o


veryclean: clean
	rm -f ../lib/libsimuv.a



calc_isint.o: \
	calc_isint.S
	../../bin/preV3_1.x calc_isint.S calc_isint.P
	../../bin/preproc.x calc_isint.P calc_isint.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_isint.o calc_isint.c
	rm -f calc_isint.c calc_isint.P
	ar rv ../lib/libsimuv.a calc_isint.o

calc_mvprod.o: \
	calc_mvprod.S
	../../bin/preV3_1.x calc_mvprod.S calc_mvprod.P
	../../bin/preproc.x calc_mvprod.P calc_mvprod.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_mvprod.o calc_mvprod.c
	rm -f calc_mvprod.c calc_mvprod.P
	ar rv ../lib/libsimuv.a calc_mvprod.o

calc_prod.o: \
	calc_prod.S
	../../bin/preV3_1.x calc_prod.S calc_prod.P
	../../bin/preproc.x calc_prod.P calc_prod.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_prod.o calc_prod.c
	rm -f calc_prod.c calc_prod.P
	ar rv ../lib/libsimuv.a calc_prod.o

calc_smul.o: \
	calc_smul.S
	../../bin/preV3_1.x calc_smul.S calc_smul.P
	../../bin/preproc.x calc_smul.P calc_smul.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_smul.o calc_smul.c
	rm -f calc_smul.c calc_smul.P
	ar rv ../lib/libsimuv.a calc_smul.o

ecqnftoeci_o.o: \
	ecqnftoeci_o.S
	../../bin/preV3_1.x ecqnftoeci_o.S ecqnftoeci_o.P
	../../bin/preproc.x ecqnftoeci_o.P ecqnftoeci_o.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ecqnftoeci_o.o ecqnftoeci_o.c
	rm -f ecqnftoeci_o.c ecqnftoeci_o.P
	ar rv ../lib/libsimuv.a ecqnftoeci_o.o

expover.o: \
	expover.S
	../../bin/preV3_1.x expover.S expover.P
	../../bin/preproc.x expover.P expover.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o expover.o expover.c
	rm -f expover.c expover.P
	ar rv ../lib/libsimuv.a expover.o

gfrffact.o: \
	gfrffact.S
	../../bin/preV3_1.x gfrffact.S gfrffact.P
	../../bin/preproc.x gfrffact.P gfrffact.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o gfrffact.o gfrffact.c
	rm -f gfrffact.c gfrffact.P
	ar rv ../lib/libsimuv.a gfrffact.o

gfsalgenies.o: \
	gfsalgenies.S
	../../bin/preV3_1.x gfsalgenies.S gfsalgenies.P
	../../bin/preproc.x gfsalgenies.P gfsalgenies.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o gfsalgenies.o gfsalgenies.c
	rm -f gfsalgenies.c gfsalgenies.P
	ar rv ../lib/libsimuv.a gfsalgenies.o

gftyper.o: \
	gftyper.S
	../../bin/preV3_1.x gftyper.S gftyper.P
	../../bin/preproc.x gftyper.P gftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o gftyper.o gftyper.c
	rm -f gftyper.c gftyper.P
	ar rv ../lib/libsimuv.a gftyper.o

inprog.o: \
	inprog.S
	../../bin/preV3_1.x inprog.S inprog.P
	../../bin/preproc.x inprog.P inprog.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o inprog.o inprog.c
	rm -f inprog.c inprog.P
	ar rv ../lib/libsimuv.a inprog.o

kenntest.o: \
	kenntest.S
	../../bin/preV3_1.x kenntest.S kenntest.P
	../../bin/preproc.x kenntest.P kenntest.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o kenntest.o kenntest.c
	rm -f kenntest.c kenntest.P
	ar rv ../lib/libsimuv.a kenntest.o

magftyper.o: \
	magftyper.S
	../../bin/preV3_1.x magftyper.S magftyper.P
	../../bin/preproc.x magftyper.P magftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o magftyper.o magftyper.c
	rm -f magftyper.c magftyper.P
	ar rv ../lib/libsimuv.a magftyper.o

mamodtyper.o: \
	mamodtyper.S
	../../bin/preV3_1.x mamodtyper.S mamodtyper.P
	../../bin/preproc.x mamodtyper.P mamodtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o mamodtyper.o mamodtyper.c
	rm -f mamodtyper.c mamodtyper.P
	ar rv ../lib/libsimuv.a mamodtyper.o

manftyper.o: \
	manftyper.S
	../../bin/preV3_1.x manftyper.S manftyper.P
	../../bin/preproc.x manftyper.P manftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o manftyper.o manftyper.c
	rm -f manftyper.c manftyper.P
	ar rv ../lib/libsimuv.a manftyper.o

matrkenn.o: \
	matrkenn.S
	../../bin/preV3_1.x matrkenn.S matrkenn.P
	../../bin/preproc.x matrkenn.P matrkenn.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o matrkenn.o matrkenn.c
	rm -f matrkenn.c matrkenn.P
	ar rv ../lib/libsimuv.a matrkenn.o

matrtyper.o: \
	matrtyper.S
	../../bin/preV3_1.x matrtyper.S matrtyper.P
	../../bin/preproc.x matrtyper.P matrtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o matrtyper.o matrtyper.c
	rm -f matrtyper.c matrtyper.P
	ar rv ../lib/libsimuv.a matrtyper.o

mistake.o: \
	mistake.S
	../../bin/preV3_1.x mistake.S mistake.P
	../../bin/preproc.x mistake.P mistake.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o mistake.o mistake.c
	rm -f mistake.c mistake.P
	ar rv ../lib/libsimuv.a mistake.o

mlist.o: \
	mlist.S
	../../bin/preV3_1.x mlist.S mlist.P
	../../bin/preproc.x mlist.P mlist.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o mlist.o mlist.c
	rm -f mlist.c mlist.P
	ar rv ../lib/libsimuv.a mlist.o

modtyper.o: \
	modtyper.S
	../../bin/preV3_1.x modtyper.S modtyper.P
	../../bin/preproc.x modtyper.P modtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o modtyper.o modtyper.c
	rm -f modtyper.c modtyper.P
	ar rv ../lib/libsimuv.a modtyper.o

nfeltoqnfel.o: \
	nfeltoqnfel.S
	../../bin/preV3_1.x nfeltoqnfel.S nfeltoqnfel.P
	../../bin/preproc.x nfeltoqnfel.P nfeltoqnfel.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o nfeltoqnfel.o nfeltoqnfel.c
	rm -f nfeltoqnfel.c nfeltoqnfel.P
	ar rv ../lib/libsimuv.a nfeltoqnfel.o

nftocs.o: \
	nftocs.S
	../../bin/preV3_1.x nftocs.S nftocs.P
	../../bin/preproc.x nftocs.P nftocs.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o nftocs.o nftocs.c
	rm -f nftocs.c nftocs.P
	ar rv ../lib/libsimuv.a nftocs.o

nftoqnf.o: \
	nftoqnf.S
	../../bin/preV3_1.x nftoqnf.S nftoqnf.P
	../../bin/preproc.x nftoqnf.P nftoqnf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o nftoqnf.o nftoqnf.c
	rm -f nftoqnf.c nftoqnf.P
	ar rv ../lib/libsimuv.a nftoqnf.o

nftyper.o: \
	nftyper.S
	../../bin/preV3_1.x nftyper.S nftyper.P
	../../bin/preproc.x nftyper.P nftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o nftyper.o nftyper.c
	rm -f nftyper.c nftyper.P
	ar rv ../lib/libsimuv.a nftyper.o

pctopflip.o: \
	pctopflip.S
	../../bin/preV3_1.x pctopflip.S pctopflip.P
	../../bin/preproc.x pctopflip.P pctopflip.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pctopflip.o pctopflip.c
	rm -f pctopflip.c pctopflip.P
	ar rv ../lib/libsimuv.a pctopflip.o

pfltopiip.o: \
	pfltopiip.S
	../../bin/preV3_1.x pfltopiip.S pfltopiip.P
	../../bin/preproc.x pfltopiip.P pfltopiip.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pfltopiip.o pfltopiip.c
	rm -f pfltopiip.c pfltopiip.P
	ar rv ../lib/libsimuv.a pfltopiip.o

pnftopcs.o: \
	pnftopcs.S
	../../bin/preV3_1.x pnftopcs.S pnftopcs.P
	../../bin/preproc.x pnftopcs.P pnftopcs.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pnftopcs.o pnftopcs.c
	rm -f pnftopcs.c pnftopcs.P
	ar rv ../lib/libsimuv.a pnftopcs.o

pnftoprip.o: \
	pnftoprip.S
	../../bin/preV3_1.x pnftoprip.S pnftoprip.P
	../../bin/preproc.x pnftoprip.P pnftoprip.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pnftoprip.o pnftoprip.c
	rm -f pnftoprip.c pnftoprip.P
	ar rv ../lib/libsimuv.a pnftoprip.o

prtopica.o: \
	prtopica.S
	../../bin/preV3_1.x prtopica.S prtopica.P
	../../bin/preproc.x prtopica.P prtopica.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o prtopica.o prtopica.c
	rm -f prtopica.c prtopica.P
	ar rv ../lib/libsimuv.a prtopica.o

qnfeltonfel.o: \
	qnfeltonfel.S
	../../bin/preV3_1.x qnfeltonfel.S qnfeltonfel.P
	../../bin/preproc.x qnfeltonfel.P qnfeltonfel.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o qnfeltonfel.o qnfeltonfel.c
	rm -f qnfeltonfel.c qnfeltonfel.P
	ar rv ../lib/libsimuv.a qnfeltonfel.o

qnftonf.o: \
	qnftonf.S
	../../bin/preV3_1.x qnftonf.S qnftonf.P
	../../bin/preproc.x qnftonf.P qnftonf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o qnftonf.o qnftonf.c
	rm -f qnftonf.c qnftonf.P
	ar rv ../lib/libsimuv.a qnftonf.o

smgftyper.o: \
	smgftyper.S
	../../bin/preV3_1.x smgftyper.S smgftyper.P
	../../bin/preproc.x smgftyper.P smgftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o smgftyper.o smgftyper.c
	rm -f smgftyper.c smgftyper.P
	ar rv ../lib/libsimuv.a smgftyper.o

smmodtyper.o: \
	smmodtyper.S
	../../bin/preV3_1.x smmodtyper.S smmodtyper.P
	../../bin/preproc.x smmodtyper.P smmodtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o smmodtyper.o smmodtyper.c
	rm -f smmodtyper.c smmodtyper.P
	ar rv ../lib/libsimuv.a smmodtyper.o

smnftyper.o: \
	smnftyper.S
	../../bin/preV3_1.x smnftyper.S smnftyper.P
	../../bin/preproc.x smnftyper.P smnftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o smnftyper.o smnftyper.c
	rm -f smnftyper.c smnftyper.P
	ar rv ../lib/libsimuv.a smnftyper.o

smtyper.o: \
	smtyper.S
	../../bin/preV3_1.x smtyper.S smtyper.P
	../../bin/preproc.x smtyper.P smtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o smtyper.o smtyper.c
	rm -f smtyper.c smtyper.P
	ar rv ../lib/libsimuv.a smtyper.o

svgftyper.o: \
	svgftyper.S
	../../bin/preV3_1.x svgftyper.S svgftyper.P
	../../bin/preproc.x svgftyper.P svgftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o svgftyper.o svgftyper.c
	rm -f svgftyper.c svgftyper.P
	ar rv ../lib/libsimuv.a svgftyper.o

svmodtyper.o: \
	svmodtyper.S
	../../bin/preV3_1.x svmodtyper.S svmodtyper.P
	../../bin/preproc.x svmodtyper.P svmodtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o svmodtyper.o svmodtyper.c
	rm -f svmodtyper.c svmodtyper.P
	ar rv ../lib/libsimuv.a svmodtyper.o

svnftyper.o: \
	svnftyper.S
	../../bin/preV3_1.x svnftyper.S svnftyper.P
	../../bin/preproc.x svnftyper.P svnftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o svnftyper.o svnftyper.c
	rm -f svnftyper.c svnftyper.P
	ar rv ../lib/libsimuv.a svnftyper.o

svtyper.o: \
	svtyper.S
	../../bin/preV3_1.x svtyper.S svtyper.P
	../../bin/preproc.x svtyper.P svtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o svtyper.o svtyper.c
	rm -f svtyper.c svtyper.P
	ar rv ../lib/libsimuv.a svtyper.o

togftyper.o: \
	togftyper.S
	../../bin/preV3_1.x togftyper.S togftyper.P
	../../bin/preproc.x togftyper.P togftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o togftyper.o togftyper.c
	rm -f togftyper.c togftyper.P
	ar rv ../lib/libsimuv.a togftyper.o

tonftyper.o: \
	tonftyper.S
	../../bin/preV3_1.x tonftyper.S tonftyper.P
	../../bin/preproc.x tonftyper.P tonftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o tonftyper.o tonftyper.c
	rm -f tonftyper.c tonftyper.P
	ar rv ../lib/libsimuv.a tonftyper.o

typer.o: \
	typer.S
	../../bin/preV3_1.x typer.S typer.P
	../../bin/preproc.x typer.P typer.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o typer.o typer.c
	rm -f typer.c typer.P
	ar rv ../lib/libsimuv.a typer.o

vecgftyper.o: \
	vecgftyper.S
	../../bin/preV3_1.x vecgftyper.S vecgftyper.P
	../../bin/preproc.x vecgftyper.P vecgftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecgftyper.o vecgftyper.c
	rm -f vecgftyper.c vecgftyper.P
	ar rv ../lib/libsimuv.a vecgftyper.o

veckenn.o: \
	veckenn.S
	../../bin/preV3_1.x veckenn.S veckenn.P
	../../bin/preproc.x veckenn.P veckenn.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o veckenn.o veckenn.c
	rm -f veckenn.c veckenn.P
	ar rv ../lib/libsimuv.a veckenn.o

vecmodtyper.o: \
	vecmodtyper.S
	../../bin/preV3_1.x vecmodtyper.S vecmodtyper.P
	../../bin/preproc.x vecmodtyper.P vecmodtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecmodtyper.o vecmodtyper.c
	rm -f vecmodtyper.c vecmodtyper.P
	ar rv ../lib/libsimuv.a vecmodtyper.o

vecnftyper.o: \
	vecnftyper.S
	../../bin/preV3_1.x vecnftyper.S vecnftyper.P
	../../bin/preproc.x vecnftyper.P vecnftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecnftyper.o vecnftyper.c
	rm -f vecnftyper.c vecnftyper.P
	ar rv ../lib/libsimuv.a vecnftyper.o

vlist.o: \
	vlist.S
	../../bin/preV3_1.x vlist.S vlist.P
	../../bin/preproc.x vlist.P vlist.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vlist.o vlist.c
	rm -f vlist.c vlist.P
	ar rv ../lib/libsimuv.a vlist.o

vmgftyper.o: \
	vmgftyper.S
	../../bin/preV3_1.x vmgftyper.S vmgftyper.P
	../../bin/preproc.x vmgftyper.P vmgftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vmgftyper.o vmgftyper.c
	rm -f vmgftyper.c vmgftyper.P
	ar rv ../lib/libsimuv.a vmgftyper.o

vmmodtyper.o: \
	vmmodtyper.S
	../../bin/preV3_1.x vmmodtyper.S vmmodtyper.P
	../../bin/preproc.x vmmodtyper.P vmmodtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vmmodtyper.o vmmodtyper.c
	rm -f vmmodtyper.c vmmodtyper.P
	ar rv ../lib/libsimuv.a vmmodtyper.o

vmnftyper.o: \
	vmnftyper.S
	../../bin/preV3_1.x vmnftyper.S vmnftyper.P
	../../bin/preproc.x vmnftyper.P vmnftyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vmnftyper.o vmnftyper.c
	rm -f vmnftyper.c vmnftyper.P
	ar rv ../lib/libsimuv.a vmnftyper.o

vmtyper.o: \
	vmtyper.S
	../../bin/preV3_1.x vmtyper.S vmtyper.P
	../../bin/preproc.x vmtyper.P vmtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vmtyper.o vmtyper.c
	rm -f vmtyper.c vmtyper.P
	ar rv ../lib/libsimuv.a vmtyper.o

vtyper.o: \
	vtyper.S
	../../bin/preV3_1.x vtyper.S vtyper.P
	../../bin/preproc.x vtyper.P vtyper.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vtyper.o vtyper.c
	rm -f vtyper.c vtyper.P
	ar rv ../lib/libsimuv.a vtyper.o

ranlib:
	- ranlib ../lib/libsimuv.a
