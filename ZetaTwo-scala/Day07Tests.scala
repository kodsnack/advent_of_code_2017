package com.zetatwo

import com.zetatwo.Day07.Node
import org.scalatest.FunSuite

class Day07Tests extends FunSuite {

  private val testinput =
    """
      |pbga (66)
      |xhth (57)
      |ebii (61)
      |havc (66)
      |ktlj (57)
      |fwft (72) -> ktlj, cntj, xhth
      |qoyq (66)
      |padx (45) -> pbga, havc, qoyq
      |tknk (41) -> ugml, padx, fwft
      |jptl (61)
      |ugml (68) -> gyxo, ebii, jptl
      |gyxo (61)
      |cntj (57)
    """.trim.stripMargin.split("\n").map(_.trim)

  test("Day07.parse") {
    assert(Day07.parse(testinput) == List(
      Node("pbga", 66, List.empty),
      Node("xhth", 57, List.empty),
      Node("ebii", 61, List.empty),
      Node("havc", 66, List.empty),
      Node("ktlj", 57, List.empty),
      Node("fwft", 72, List("ktlj", "cntj", "xhth")),
      Node("qoyq", 66, List.empty),
      Node("padx", 45, List("pbga", "havc", "qoyq")),
      Node("tknk", 41, List("ugml", "padx", "fwft")),
      Node("jptl", 61, List.empty),
      Node("ugml", 68, List("gyxo", "ebii", "jptl")),
      Node("gyxo", 61, List.empty),
      Node("cntj", 57, List.empty)
    ))
  }

  test("Day07.findRoot") {
    assert(Day07.findRoot(testinput) == "tknk")
  }

  private val challengeinput =
    """
      |yvpwz (50)
      |vfosh (261) -> aziwd, tubze, dhjrv
      |xtvawvt (19)
      |nspsk (24)
      |sgtfap (19) -> bohjocj, bqvzg
      |oyuteie (52)
      |irrpz (226) -> cibfe, hemjsj, upbldz
      |vtvku (426)
      |vbsfwqh (6055) -> govhrck, pglpu, rwuflbi, ppgaoz
      |nupmnv (47) -> cngdg, olgsb, lmvmb
      |ulndqey (71)
      |fujgzbt (198) -> fbesgp, hewtnrw
      |nsbvvsi (39)
      |ajvtdl (36)
      |xrgca (85)
      |mksrqb (45)
      |ozfsktz (56) -> xzwjii, uhxjy
      |peretma (15) -> suzsw, ycvvjgc, cdyhvr, jixggay
      |boplau (77) -> boggvxt, cnyasj
      |rzqffr (84) -> tbppaj, htyeqf, pgnyu, ruhqn
      |shkkwp (5)
      |bpptuqh (68) -> ugxls, zlshut, ltqljtw
      |bngres (944) -> ktwby, tblhhg, jzgpty, skbprng
      |tjnyo (55)
      |ujfeg (13) -> vldxkw, kfbsjv, rlqwaz, dvwsrc, ymxlwf, zvmhx, wfdxfxq
      |mxplky (35)
      |ezkqh (91)
      |kozgi (48)
      |pgnyu (94)
      |yhunajf (25)
      |pvpmt (77)
      |cvitrpt (88)
      |zjwih (46) -> cvitrpt, chtamif
      |mhfnxk (6) -> jddyhz, gvrhj, ctpdk, oprvyxy, luzjys
      |dbrnqc (77)
      |iorlbdv (43)
      |twwzhwf (118) -> ndgupvi, aumbaa
      |mvngvtg (67)
      |kwkprrw (187) -> uobxcai, aklrjg
      |wtvffu (120) -> vzxvex, mtsbrje, slfile
      |vjwivnq (52)
      |cbwbdsv (157) -> przuau, atjtgjx
      |rwuflbi (8) -> lapoix, dkdovw, spgcwtn
      |upbldz (27)
      |xgnqi (64)
      |ksotbs (48) -> cqbvru, tqbvdu
      |romrjs (55) -> vhilqk, gzxuw
      |ftmwqqj (76)
      |kqpvqie (63) -> qomhp, fwvsi
      |xxrsnzv (39)
      |trqfblp (85)
      |rmjktk (28) -> wtkfiw, mlrdsj, pnicdos, woujz, psrzr
      |lwygknn (96)
      |ctgbkrb (76) -> iavuhwe, onvkja
      |iqbrs (67) -> tghoyv, hoheog, kjpzwp, wwvad, ezmjqnt
      |efuqu (136) -> umljkr, qblnh
      |egwjjg (85)
      |dgtvwiy (27)
      |ndgupvi (28)
      |zdvai (85)
      |auhio (82)
      |dywjt (40)
      |hhboca (18)
      |pptbkz (96)
      |iqsvbk (73)
      |nwjibjk (31)
      |veclzy (308) -> dohjma, hbiwkt
      |repak (139) -> bcjxhps, eyckbl
      |xguqlvl (74)
      |rkjmp (59)
      |eqviuw (171) -> mqlsvih, lrnjjfq, njgkkxo
      |zogylog (80)
      |kroqr (38)
      |onvkja (49)
      |tedehrz (94) -> ipqjff, dmiqf
      |lhwyt (287) -> jbwbw, htyyatf, ppvwkei, vtbzq, pynomi, uswsg
      |mrbqk (64)
      |aoxtau (64)
      |gvrhj (59) -> qurrva, xrgca
      |lfksu (72)
      |tnwle (49)
      |dgnpr (93)
      |ucsxzhl (21) -> tpefei, ntkeax, jvayv, yuobv
      |wbibf (183) -> pvtat, ygnww, akngdu, swpkkpi
      |ljaktj (21939) -> seeqikh, mqrfbqc, ihnus
      |agqkf (69)
      |tubze (48)
      |fcapw (105) -> nkhzrd, shkkwp
      |sdied (47)
      |zfmeblt (56)
      |wqyzjzi (41)
      |zxjeza (185) -> ioumv, pjersb
      |vecxd (56) -> civozek, qzsypj
      |dkxebg (73) -> atrmuc, mhfnxk, zwwbw, ryaotx, yqhmb, yztqpc
      |oqiye (35)
      |edyqn (60)
      |fujwzoc (404)
      |llcbiqi (79)
      |yejkld (41)
      |utbev (25) -> hsxru, jfuxeo, zyshq, eznabc, lgsda, uobxonm
      |ojxyv (79)
      |vbpde (20)
      |fyjowg (26)
      |yfzjc (31)
      |obwzec (41)
      |zcanxq (85)
      |woujz (125) -> qntvn, kwzrzn
      |adhwzp (305) -> agqkf, yallk
      |zvcfznz (184) -> rjuhrpu, yzwnh, hikik
      |dxbrl (66)
      |appays (423) -> nupmnv, cyppxr, rqoczb
      |rgndu (81) -> tsbbzu, dtxrjg
      |jncex (74) -> rrdczem, bhhgpe, gtvnow, vndrx
      |cfvbuip (53)
      |vsqfx (29)
      |zocaag (38)
      |ppymmsf (19)
      |amwxj (69) -> pptbkz, kweqtf, jwmbs
      |svadhfo (99)
      |xdsbnr (8)
      |duvrzrl (22)
      |dfaro (8)
      |vgugdtt (220) -> nxpakq, fhsecp
      |fwddmmv (43)
      |igaww (28)
      |bbxbrsh (31)
      |swpkkpi (13)
      |bkqexxz (77)
      |ovfduq (16)
      |rtzce (39)
      |gmwto (119) -> wbeizj, refgrip
      |rmdhj (24)
      |yeref (77)
      |ifstrgw (23) -> qpixldb, tukirqp, bwcyqb, bzbmt
      |untdpje (45) -> owimy, yejkld
      |esiwujq (41)
      |emvxet (131) -> vecdh, ftgvx
      |mztuzb (764) -> jgzvrf, eaqiocy, fsagr
      |bwnabqh (83)
      |gypsfc (43)
      |bhemin (44)
      |imydd (164) -> iabqb, vdpnsak
      |qajpehv (49)
      |oxnfnsv (76) -> twwzhwf, uiyyc, gfaamu, umhcrc, bcjpzpk, vrqeade
      |qfdldyu (231)
      |dmsmgs (29)
      |oqady (7) -> mhtzh, cpreh
      |zbhwrc (759) -> esrilo, dcngdo
      |cyppxr (272) -> pitmcu, nvlqab
      |jtzjrke (45)
      |przuau (59)
      |eexkce (44)
      |xsewlv (124) -> fwfpmti, rszjhxn
      |fbesgp (28)
      |sxegjbz (297) -> yhycc, gxmry, favzt
      |nxpakq (17)
      |hbvvse (98)
      |ygzwut (83)
      |cngdg (93)
      |tfzum (69)
      |ccghjn (58)
      |ylbpwah (190) -> htlpx, eduzave, peqgox, fkqkfdu
      |mobbhp (141) -> clgbo, jtzjrke
      |icdlpb (62)
      |wkrtcw (1663) -> qqzhz, ybewhak, mazbb
      |uswsg (312)
      |zdvlgn (63) -> rmpryj, qrtdtt
      |hfcifm (107) -> tpfuxx, wdivd
      |cltqhc (25)
      |gnrnwtz (513) -> efxakc, jxlgwb, ksotbs, gvayfu, wqvtdc
      |rdufpid (25)
      |kszmj (137) -> eemfgbx, amvjukd
      |ykuto (662) -> pvuoltd, kcyiwqs, kbjnzw, kszmj
      |ckswvj (264) -> cleanrs, ntixh
      |czhsx (51)
      |luayjsp (47) -> alhjba, qjghc
      |djnsvq (295) -> nbnqidn, ijjfn
      |qxzfv (57)
      |qyzja (94)
      |rmpryj (96)
      |eyreht (45)
      |vzkii (216)
      |rwheyic (68)
      |rjmdre (21)
      |qntvn (71)
      |lescv (32)
      |qomhp (32)
      |oegwh (70)
      |tukirqp (85)
      |pumxr (103) -> wvpwez, kiuiq
      |fjrpc (89)
      |gmoliax (1327) -> jniisu, cfafhwl
      |wsrwgvc (80)
      |zhgzg (62) -> aonfu, vqiqglo
      |fxcuah (208) -> uofigyp, kfxyzqc
      |fnjnhmk (76)
      |zlshut (62)
      |hsnbry (26)
      |pjnyxo (30)
      |luzjys (115) -> kisjb, owsosl
      |vecdh (14)
      |vfrqc (13)
      |udjcwm (18)
      |twpmx (30)
      |oiysq (64)
      |lcazsyd (78)
      |ryaotx (399) -> lmctbp, imydd, wlkatbq, sikzsc
      |rbnfwkf (51)
      |kdtpg (4260) -> lymwlyg, xgqzb, appays
      |djvps (30)
      |vjqjwk (76)
      |pbrdt (66)
      |rciilr (33)
      |heumdl (75)
      |whqvs (146) -> ttxrd, qxuakjr
      |zvtxa (77)
      |cpkkq (18) -> romrjs, xmpdevf, nnofr, qgqou, nmkjx, nbvwta
      |sxada (7) -> dgrwv, irlfj, rmjpia, ciafn
      |frbmr (67) -> tnwle, nnyqes
      |tgksxw (53) -> dkffgot, yvpwz
      |ijvux (77)
      |tblhhg (44)
      |xxsivgz (17) -> kkhfzgn, rbqcbvl
      |ylxxmlt (83) -> qxzfv, dacbtyf, aqhcy
      |vndrx (248) -> xecqd, tznkdt
      |jwezuh (57) -> kxrxtq, cijfsu
      |ztqvzwj (86)
      |dluyef (1987) -> zcicmp, qkhhg, eivrwbt, iqzdu, rmvry
      |ybzvav (873) -> agwyte, kawloxz, bmdxyf
      |pvuoltd (115) -> glgrdm, gfizf, bnehbkl, lkyeyn
      |ceefghr (21) -> mksrqb, saqjax, llild, qwvvha
      |khphs (101) -> qwlepd, acgrw
      |yxvgj (13)
      |zifogt (85)
      |wgwlbz (83) -> uwaij, qklota
      |xlyvge (235) -> zgnoqml, trqfblp
      |qaxvec (41)
      |ylkfgx (6)
      |pzgvdt (37)
      |vtzdfjg (77)
      |tyiekxm (24)
      |jaiqusy (18)
      |avhkram (73)
      |akluijb (77)
      |bohjocj (73)
      |ofoto (1287) -> sgrcmj, jxykl
      |qgqou (227)
      |xtoaq (18)
      |peqgox (25)
      |kobcmy (64) -> haeymgy, egwjjg, zcanxq, zifogt
      |namzy (79)
      |vldxkw (463) -> gmwto, aflmt, boplau, khphs, qlthpj, epqsj
      |chtamif (88)
      |vqsuh (92)
      |iofsrh (35)
      |njgkkxo (17)
      |zsqqhe (94)
      |xupdam (64)
      |bqvzg (73)
      |hmetm (889) -> aklagd, ceefghr, whcxfwf, guztl
      |hoheog (296)
      |llsvd (18)
      |giupn (30)
      |dfzfwun (64)
      |nmfvmam (125) -> qxwlhxh, obwzec
      |ioumv (86)
      |gxmry (143) -> cyvplfd, wmcusr
      |ywgvsdb (131) -> fzfxs, yvdkbo, igaww
      |pwsye (49)
      |mywezi (407) -> gimkyms, bnxvusb
      |fzfxs (28)
      |kurgrkq (76)
      |txeucf (61)
      |gjwflt (84) -> xmfzu, gcbjhu, xxnannn, bwnabqh
      |vrgxe (1226) -> zbfyg, rocbcw, zouml, wbibf
      |izwze (16)
      |jwmbs (96)
      |euvev (46)
      |dgzvf (30)
      |iezdimc (82)
      |zkhll (992) -> bbqtwv, xupdam
      |jhxxfq (71)
      |hemjsj (27)
      |ryxkvxj (124) -> bhemin, apghde
      |qxuakjr (54)
      |aonfu (95)
      |dvopaww (98)
      |uobwwa (69)
      |dojvyuv (96)
      |ezcmm (886) -> ntjmwf, qfdldyu, vokxlx
      |yzwnh (15)
      |jfqanu (302) -> dcgarog, tcpqh
      |gfizf (14)
      |kvbdsv (46)
      |qzsypj (98)
      |vyffcrm (24)
      |iuoxs (13)
      |zitfb (23) -> ctagl, ddpgq
      |yueoma (46)
      |bbqtwv (64)
      |hgsng (45)
      |wgehfu (77) -> lescv, hnjbsg, bxvwe, evmuxia
      |arwqmho (66)
      |amvjukd (17)
      |ntixh (10)
      |zfzblty (47)
      |cxzuprb (592) -> texfyi, dvgstr, irhxzg
      |ekqux (76)
      |abxalr (697) -> zjwih, gjwuf, eqviuw
      |choiui (65)
      |tgjdwlh (24)
      |glhsr (60)
      |rtymngs (66)
      |rocbcw (169) -> djizg, dtnaqds
      |bjwws (46) -> evgtp, ztqvzwj
      |gowbiey (78)
      |yqhmb (497) -> njgrpbo, tedehrz, bjwws
      |lapoix (240) -> xkizl, dyhate, disan
      |vckqsrm (30)
      |sxdljm (66)
      |frpmd (13)
      |uwhwsv (86)
      |wknic (47)
      |pnicdos (165) -> czhsx, rbnfwkf
      |wrsik (80)
      |wbogdd (66) -> eibtll, ppmvpn
      |fyrqw (28) -> ekqux, zxoqwjv, ipogzy, dhzuvup
      |uttjzap (22)
      |gqjkk (41)
      |gcbjhu (83)
      |bnxvusb (21)
      |bxvwe (32)
      |difjqqd (47)
      |xxnannn (83)
      |lxzucvk (94)
      |ehynj (98) -> ijvuozb, wutdi
      |vwkbje (25)
      |ciafn (62)
      |pyyuj (34)
      |zofljd (685) -> hfcifm, emvxet, ahrdgu
      |zyshq (140) -> dpcmm, eosuf
      |zgslahq (101) -> ximrxj, auvxopo
      |xszci (72)
      |fomxzjj (47)
      |mcduoz (6)
      |rcltx (73) -> djnsvq, hqmum, ifstrgw
      |pemna (98)
      |fgnsyw (39)
      |tfppg (77) -> uwhwsv, fmapm
      |tohlady (84)
      |gzxuw (86)
      |mkdiuil (96)
      |qfhkgt (52)
      |csxwyly (47)
      |intuzzk (82) -> jqqxv, dlnyi, pbides, qtcqtv
      |bfxhl (78) -> qvmorke, pazbvum
      |eduzave (25)
      |kwbni (74) -> abxalr, bbsuv, gnrnwtz, rmjktk, eqcnl, pdwesa, sunvhgy
      |hhnvuv (83)
      |ismgnve (68)
      |alhjba (84)
      |mspkmg (94)
      |rszjhxn (34)
      |frleu (60)
      |mewfm (48) -> gowbiey, yevks
      |mpulnxr (42) -> eziuhsd, xsewlv, tckcxhb, bfxhl
      |mzksj (68)
      |shnqfh (1649) -> wnnov, mdtniv, fwpuy
      |bxpfop (153)
      |zucsr (26)
      |gmpqmio (93)
      |wzjbp (174)
      |zcicmp (301)
      |ppvwkei (93) -> eqjfyj, lghygm, grrycy
      |tcsoaw (239) -> kzfzp, oypzs
      |nnsial (78)
      |mazbb (98) -> dsxhhub, fqoqkzk
      |lclbeiq (81) -> bwxicc, uttjzap
      |jddyhz (91) -> vmmww, mvalh
      |umqrwk (132) -> itvhd, jbuxnpr, mxopf
      |qxfan (34)
      |cdafdq (26)
      |drrjnr (80)
      |kxrxtq (68)
      |cnyasj (56)
      |kpdbki (38)
      |dgzoyx (72)
      |zwwbw (155) -> eqbvn, qcghv, tfppg, xaanoft
      |zsxbg (22)
      |fwvsi (32)
      |hefgter (6) -> pirieql, hikocbe
      |mwelezd (81)
      |eptcqns (16)
      |jmbiky (96)
      |gnozwfo (242) -> vqsuh, cxlfgl
      |wtkfiw (48) -> owresw, grqjew, okbzzwd
      |ltqljtw (62)
      |lymwlyg (72) -> snkox, adhwzp, cvdjts
      |mgeizij (60) -> sbcuc, rqrfl
      |zghvta (57)
      |uqcqc (85)
      |tozwp (19)
      |nqjrds (81)
      |cfufhn (11)
      |yznhjg (60) -> choiui, yhecio, lprpgxe
      |qtbhnxr (27)
      |bwdfws (27)
      |kiuiq (89)
      |zjfrc (141) -> zghvta, lkqiqa
      |ooiyeep (80)
      |xiawjb (38)
      |wgzdt (216) -> vfrqc, frpmd
      |lugkrb (36)
      |mvalh (69)
      |cruxrmy (52)
      |azwmkej (33)
      |tqbvdu (61)
      |szvlte (21)
      |bzbmt (85)
      |gcczhgd (43) -> eecoekq, kwpnxyh
      |jxlgwb (24) -> pzahn, yadtxl
      |gfaamu (8) -> ygzwut, hhnvuv
      |ntjmwf (211) -> owqdo, umvvwsq
      |rqhrb (19)
      |jixggay (28)
      |gavjzk (91)
      |mbydswv (69)
      |unqbwiz (10) -> rixge, lkwapf, phvbwg
      |veycd (62)
      |lmctbp (106) -> wqyzjzi, gqjkk
      |jwpjy (94) -> ywlub, rtymngs
      |febjzqn (46461) -> mwtojre, iqmqju, dkxebg
      |yvdkbo (28)
      |iayzdx (7181) -> fakyd, fjwmd, uzicvdh
      |uobxonm (118) -> wrsik, wsrwgvc
      |sehxgj (41) -> wpezjoi, dcnuouj, vrpqev, kjwvqdz, vzkii
      |eziuhsd (192)
      |gcichoe (79)
      |jwzmsv (45)
      |fmapm (86)
      |rbtvx (53)
      |sgkksme (94)
      |zmces (86)
      |rmjpia (62)
      |feiki (376) -> oqady, fcymcb, wlleabp
      |sgrcmj (54)
      |dohjma (76)
      |kgzqclo (71)
      |eqjfyj (73)
      |zcjrk (1009) -> zdvlgn, sxada, yznhjg, pnoxhe
      |zhudrmb (78) -> mvngvtg, kvags
      |iylwxgn (98) -> edebwk, gjwflt, rlapq
      |beraoor (10) -> pumxr, gasnep, ulznkvm
      |gxnoomf (185) -> ihrhkj, cfufhn
      |fhoprd (71)
      |pbides (59)
      |xqgjvz (192) -> twpmx, zwofu
      |mexuge (52)
      |rbfbf (47)
      |oprvyxy (125) -> oyuteie, yibxqhs
      |eqcnl (637) -> kgjcj, wgzdt, rrgffal
      |kikfs (40)
      |ntvul (77)
      |bwxicc (22)
      |rttwea (55) -> fnjnhmk, kurgrkq
      |kfxyzqc (9)
      |ddmrgzp (69)
      |clgbo (45)
      |qoapjhr (173)
      |kkhfzgn (88)
      |njgrpbo (74) -> dgzoyx, rlywif
      |bwcyqb (85)
      |esrilo (47)
      |blutjw (717) -> fxcuah, efuqu, jwpjy
      |owimy (41)
      |oeeqrsd (62)
      |akoqk (16)
      |owqdo (10)
      |fwpuy (26) -> eqnpvwk, lbhxdbr, lqqkjjr, tlvpv
      |tzqzk (52)
      |gxobd (91)
      |npqroe (36)
      |pstaxvr (761) -> peretma, kqpvqie, untdpje
      |boggvxt (56)
      |uobxcai (10)
      |vmyda (63912) -> rcltx, ajwxaa, yvqasth
      |jznrci (51) -> mclgebd, emdsyso
      |ktgfsm (50)
      |kweqtf (96)
      |mtsbrje (66)
      |rjuhrpu (15)
      |zgnoqml (85)
      |qlthpj (57) -> arwqmho, yydyjr
      |cdudjbj (128) -> iofsrh, nuuwbui, mxplky
      |estwket (94)
      |adjlg (67)
      |jbwbw (114) -> dxbrl, lhdhko, fdjhpq
      |ezfky (71)
      |rrdczem (71) -> dgrfhvi, adjlg, ajyqxh
      |xqrmgdk (6543) -> unqbwiz, cxzuprb, rmkhel
      |nmkjx (213) -> wycesn, gpfipvk
      |qklota (16)
      |jbuxnpr (30)
      |xtzqooh (27)
      |vbcfe (49938) -> yuepckc, ybzvav, sxapjc, cfvlt, dluyef
      |drzrtpi (96) -> nuuqqqy, scqutwb
      |xkfps (7)
      |nvxlr (49)
      |hazbs (31)
      |ajyqxh (67)
      |guhyk (66)
      |ipwxws (190) -> difjqqd, wknic
      |akngdu (13)
      |evgtp (86)
      |eznabc (150) -> dvhbwl, xnuoisk
      |limjm (52)
      |bykjeka (71) -> sdied, zfzblty, csxwyly, fomxzjj
      |gpfipvk (7)
      |cpreh (86)
      |qurrva (85)
      |sikzsc (46) -> dpetvw, pridma
      |vokxlx (69) -> gadnfmt, nqjrds
      |scbycx (193)
      |qjghc (84)
      |ctpjjsh (964) -> thlbs, wgehfu, fetns
      |uzicvdh (42) -> altsh, xhhhix, calvq, bykjeka, iucuw
      |tpefei (109) -> qtznzyx, myznok
      |sizfqfs (116) -> vsqfx, dmsmgs
      |qumahjn (71)
      |ctagl (97)
      |hewtnrw (28)
      |ocpzltp (67)
      |ihnus (40) -> vrgxe, shnqfh, auzded, hkhsc, jwddn, mcxki, lhwyt
      |iuydxn (253) -> fhoaub, kmnjo
      |evubadn (49)
      |wpezjoi (112) -> zpxqtrg, tzqzk
      |qtznzyx (57)
      |dcnuouj (76) -> oegwh, ztzfled
      |ddpgq (97)
      |ktrkhe (67)
      |podcsx (71)
      |univhdj (26)
      |puxaz (60)
      |jadome (50)
      |uplbokf (5475) -> vbxqhoy, cpkkq, iqozz
      |llild (45)
      |lylaoh (170) -> lomhz, tzjzmmv, cefbp
      |owsosl (57)
      |iqozz (681) -> syykbn, mbmzme, cdudjbj
      |nvdon (345) -> dgzvf, djvps
      |iigqfh (327)
      |ctatrbo (279) -> tyiekxm, rmdhj
      |yevks (78)
      |cipxwb (85)
      |edmljb (134) -> ligev, glhsr
      |yallk (69)
      |owtxsq (71) -> zxjeza, pzgvsxu, amwxj
      |pejmc (151) -> fjvoff, esgqip
      |pridma (71)
      |vdpnsak (12)
      |hlfbt (200) -> univhdj, xnxdmdb
      |wyuwk (315) -> ibcbvy, ztaff
      |phvbwg (86) -> yachdf, utncpu, tohlady
      |nbnqidn (34)
      |tnyjkok (93)
      |kwpnxyh (41)
      |yachdf (84)
      |ximrxj (42)
      |appok (73)
      |rrgffal (78) -> trxgpy, zmjfa
      |uiyyc (126) -> nspsk, plxdglq
      |rcxtjte (210) -> drrvse, szvlte
      |ruild (9) -> zqdezgy, cxpoqyu
      |mqlsvih (17)
      |xgqzb (451) -> mgeizij, hefgter, ajtjnwp, ljhezx, pwwqvhw
      |gmdcbyg (214) -> mexuge, limjm
      |mxopf (30)
      |wnnov (170)
      |qgwcfll (95)
      |smtbsys (49)
      |jiyuw (40)
      |sunvhgy (218) -> fmlhgs, clmyzsu, zvcfznz, xrkca, jznrci
      |wycesn (7)
      |sbgwln (66)
      |dkffgot (50)
      |ximrdyg (217) -> tpbgp, ibmcytl
      |mvqfvit (38)
      |spgcwtn (63) -> yeref, itxaax, ntvul
      |apmpzd (46)
      |njkeu (67) -> vecxd, rpcoxd, emqoxss, elusirt, hlfbt, xqgjvz
      |irlfj (62)
      |zxoqwjv (76)
      |vjwlck (28)
      |ezmjqnt (146) -> wdssrl, gwcig
      |plzfjy (41)
      |beeeaye (71)
      |nqkwmyd (254)
      |hbiwkt (76)
      |hspol (20)
      |ntjawca (63)
      |yuobv (91) -> vtdpkof, basjwp, pfvpb
      |lqqkjjr (36)
      |zzqwzy (48) -> cnbzj, vftqnj, mywezi
      |goyzt (22)
      |apghde (44)
      |ahrdgu (23) -> ismgnve, rwheyic
      |vqiqglo (95)
      |ruclz (25)
      |wuqbe (98)
      |nedbkp (49)
      |fpmipcr (40)
      |gadnfmt (81)
      |kxrfley (55)
      |thlbs (59) -> iqsvbk, tbyihc
      |wqvtdc (126) -> uyjre, dvkrlzc
      |omfvqhv (29) -> iorlbdv, fwddmmv
      |lihivo (81)
      |ligev (60)
      |iabqb (12)
      |zwjqar (71)
      |ddsqd (61)
      |wwvad (23) -> owzybm, gavjzk, gxobd
      |plhybj (48)
      |rgyamx (79)
      |trxgpy (82)
      |vzxvex (66)
      |favzt (69) -> qxfan, pyyuj, lhahl
      |atrmuc (1081) -> qrsgca, bhthbfj
      |mqrfbqc (9769) -> vbqtd, ykuto, mgktiii, iylwxgn
      |ihkcni (66)
      |ttxrd (54)
      |dvhbwl (64)
      |nlhxju (31)
      |kjwvqdz (140) -> zocaag, gszqlv
      |gulset (80)
      |vubst (114) -> giupn, vckqsrm
      |pvejq (52)
      |lhahl (34)
      |rqoczb (310) -> ropzx, xdsbnr
      |xhhhix (259)
      |ictdnyf (1551) -> ezfky, ckxblyq
      |jexvtb (15)
      |fmlhgs (103) -> ntjawca, jwpwt
      |fcymcb (17) -> mwelezd, jaoiiae
      |cepddei (195) -> ppymmsf, mcdmpq, tozwp
      |suzsw (28)
      |dlnyi (59)
      |nzrfhb (198) -> xwpwer, vjwlck
      |kmnjo (35)
      |itvhd (30)
      |tpbgp (11)
      |syykbn (127) -> teastj, ntazqjk
      |vhilqk (86)
      |ctpdk (31) -> yzciq, ljlotlp
      |putpp (92) -> pbrdt, ihkcni, sxdljm
      |peydhei (737) -> dojvyuv, nnogow, lwygknn, ndajgou
      |yzciq (99)
      |xmfzu (83)
      |plzgfx (98)
      |qckem (28)
      |kuakyv (77)
      |qpixldb (85)
      |nnjbjm (23) -> cgwnn, veclzy, rzqffr
      |nrkdm (200) -> dgtvwiy, qtbhnxr
      |xwkski (59)
      |mgktiii (827) -> ggbxd, gjfoe, qoapjhr
      |elusirt (106) -> appok, avhkram
      |ttkboa (24)
      |ckxblyq (71)
      |disan (18)
      |owresw (73)
      |pyuuxw (39)
      |hwsrjah (176) -> pvejq, cruxrmy, vjwivnq
      |skbprng (44)
      |lkyeyn (14)
      |mdtniv (82) -> eexkce, oiiagw
      |ljhezx (130) -> jpxogsl, pjnyxo
      |upsiumf (18)
      |glgrdm (14)
      |rvcmif (288) -> jdmjou, ddmrgzp
      |wvsspk (25) -> lqnwffm, edgplu, qyzja
      |umljkr (45)
      |ggbxd (67) -> jikpfbk, siqksje
      |kuujprz (67) -> ctatrbo, xibdlh, wyuwk, siflauk, iigqfh, jhwltnv
      |aklagd (201)
      |lprpgxe (65)
      |auvxopo (42)
      |uorika (69)
      |avbgwvm (81)
      |nnogow (96)
      |iybvphk (85)
      |sxapjc (129) -> peydhei, sehxgj, lgtffok
      |utrdhz (75)
      |nbvwta (153) -> bbviexo, pzgvdt
      |jzgpty (44)
      |qqzhz (32) -> eyreht, xxswgx
      |ropzx (8)
      |xaanoft (42) -> cwgrjoh, uorika, uobwwa
      |ybnpc (307) -> dibqua, ozfsktz, txrxyqh
      |cfvlt (753) -> rusayd, feiki, ucsxzhl
      |ruxuw (43)
      |ywpjusg (64) -> joxmxc, mzksj
      |qtcqtv (59)
      |qwddgc (82)
      |eyckbl (58)
      |lgsda (44) -> lcazsyd, mwdfwe, nnsial
      |tlvpv (36)
      |rlqwaz (901) -> sizfqfs, ehynj, wzjbp, vubst
      |fgbnlu (66)
      |zvmhx (105) -> tcsoaw, rtnpvf, lbkvgme, xtttnfp
      |oiiagw (44)
      |jpxogsl (30)
      |lomhz (78)
      |calvq (85) -> ccghjn, lpascsz, zkecjv
      |ljlotlp (99)
      |jqqxv (59)
      |iqzdu (187) -> itygd, cdvmqs
      |ugkey (86)
      |tjjrys (94)
      |dtjhnzr (85)
      |tqeeva (214) -> xwkski, rkjmp
      |tznkdt (12)
      |daiah (26)
      |cwgrjoh (69)
      |dibqua (24) -> rgyamx, gcichoe
      |scqutwb (94)
      |yeifw (71)
      |dyhate (18)
      |acgrw (44)
      |fndpz (18)
      |pynomi (170) -> kgzqclo, ygvkw
      |kcyiwqs (35) -> givljl, yntnjp
      |lbkvgme (223) -> jadome, dtwbpl, ktgfsm
      |ygvkw (71)
      |dgsutv (25)
      |rlywif (72)
      |nevpm (49)
      |xtttnfp (73) -> heumdl, axgpyq, utrdhz, paeea
      |ptmqo (284)
      |ibmcytl (11)
      |ejwno (80)
      |mcdmpq (19)
      |azvke (170) -> wscktm, jexvtb
      |govhrck (176) -> vuqriq, crfse, eoditdi
      |tzjzmmv (78)
      |dhjrv (48)
      |dlifqat (49)
      |ruhqn (94)
      |mhtzh (86)
      |bhhgpe (124) -> bywwy, xguqlvl
      |ucicsdu (199) -> itvizjy, wsnqied
      |agwyte (498) -> gcczhgd, lclbeiq, rgndu
      |gapjnb (200)
      |pitmcu (27)
      |vtdpkof (44)
      |joxmxc (68)
      |mclgebd (89)
      |refgrip (35)
      |hsxru (30) -> oeeqrsd, icdlpb, veycd, dlrpnot
      |jikpfbk (53)
      |usztpox (160) -> goyzt, eagggd
      |aqhcy (57)
      |umhcrc (174)
      |qwvvha (45)
      |crxnz (10)
      |mbmzme (37) -> qajpehv, dlifqat, bponwxc, hjzehyw
      |uyjre (22)
      |tsbbzu (22)
      |tenzzu (67)
      |ijvuozb (38)
      |oypzs (67)
      |ymxlwf (327) -> nzrfhb, wbogdd, fujgzbt, nqkwmyd, vgugdtt
      |dvgstr (87) -> rqhrb, xtvawvt, receu
      |yzuygum (57) -> oiysq, jibdphs
      |vuqriq (238)
      |lsysd (68)
      |meayff (35)
      |guztl (73) -> mrbqk, aoxtau
      |rtnpvf (177) -> pwsye, nevpm, nvxlr, smtbsys
      |zbqpk (112) -> apmpzd, yueoma
      |bbviexo (37)
      |gimkyms (21)
      |fjwmd (692) -> luayjsp, njqzaxg, ywgvsdb
      |igfhu (31)
      |qkhhg (105) -> yknwap, qqqsv
      |ybewhak (122)
      |xkizl (18)
      |siqksje (53)
      |vtbzq (178) -> tenzzu, ocpzltp
      |giblwzi (7)
      |atjtgjx (59)
      |bjlwfmo (49)
      |jibdphs (64)
      |cxlfgl (92)
      |wltlu (1495) -> swumt, qeosq, guhyk
      |lkqiqa (57)
      |qwlepd (44)
      |rmvry (145) -> ejzfwt, pknjpc, qfhkgt
      |xmpdevf (185) -> rjmdre, abcyotz
      |utwzg (10)
      |lpascsz (58)
      |abcyotz (21)
      |grqjew (73)
      |vindom (25)
      |tzmes (28)
      |ktwby (44)
      |gfsnsdu (38)
      |ywlub (66)
      |iryrfjs (31)
      |fwfpmti (34)
      |givljl (68)
      |edebwk (161) -> dtjhnzr, cipxwb, uqcqc
      |aziwd (48)
      |ajtjnwp (46) -> clfrs, qdwkxia
      |nvlqab (27)
      |dvwsrc (1517) -> jiyuw, dvtdje
      |basjwp (44)
      |rhchuf (67) -> sedysm, nedbkp
      |cdvmqs (57)
      |dkdovw (262) -> afglbpz, ovfduq
      |seeqikh (10944) -> mztuzb, zovbvcr, nnjbjm
      |bgcrdqu (174)
      |huqpiix (121) -> eptcqns, aiget
      |bywwy (74)
      |aujxmm (89)
      |xecqd (12)
      |tbppaj (94)
      |zkecjv (58)
      |utncpu (84)
      |grrycy (73)
      |htlpx (25)
      |pvtat (13)
      |dfdlzzt (71)
      |uwaij (16)
      |edgplu (94)
      |aflmt (153) -> puyiail, jaiqusy
      |eoditdi (10) -> boqtohm, odsrv, iblrer
      |imshim (39)
      |nioeugr (38)
      |eagggd (22)
      |ulznkvm (211) -> meayff, oqiye
      |psrzr (213) -> bwdfws, sdrhiyo
      |vmmww (69)
      |blofdav (18)
      |zbfyg (49) -> xoqxrbl, dgnpr
      |qzhyumq (25)
      |dpcmm (69)
      |qvmorke (57)
      |exuwhfs (89) -> qumahjn, kkvkz
      |rdqvi (56)
      |axlgwj (38)
      |vbxqhoy (744) -> nquonb, zhudrmb, ryxkvxj
      |rqlaf (67)
      |mlrdsj (107) -> tzdtm, etmvojh
      |tnzqj (1057) -> nbpic, ctgbkrb, bgcrdqu
      |lghygm (73)
      |wvjjht (60)
      |wmvht (36)
      |xibdlh (255) -> tgjdwlh, vyffcrm, ahridq
      |pjersb (86)
      |pdwesa (407) -> ximrdyg, xaebyo, qqpsrts, ucicsdu
      |tflulu (3299) -> ezcmm, tnzqj, njkeu, ctpjjsh
      |rmkhel (55) -> olkcm, yquqk, iuydxn
      |odsrv (76)
      |kfbsjv (73) -> ylxxmlt, whqvs, edmljb, bpptuqh, jwjggy, nrkdm
      |vywqra (18)
      |bnehbkl (14)
      |lkwapf (290) -> ttkboa, xvcikqe
      |kawloxz (45) -> rttwea, nmfvmam, kwkprrw, gxnoomf
      |drrvse (21)
      |tklfj (465) -> fcapw, omfvqhv, wgwlbz
      |receu (19)
      |zqdezgy (72)
      |ntkeax (91) -> sbgwln, fgbnlu
      |boqtohm (76)
      |rpcoxd (252)
      |hiqqg (82)
      |cdyhvr (28)
      |snkox (67) -> mspkmg, lxzucvk, zsqqhe, sgkksme
      |zpxqtrg (52)
      |olgsb (93)
      |hikocbe (92)
      |xwpwer (28)
      |kzfzp (67)
      |dfyyjta (33822) -> hvhjh, ujfeg, iayzdx
      |hvhjh (6551) -> uveybq, iqbrs, zrnnyet
      |kjpzwp (160) -> fmvyjwj, lsysd
      |htyyatf (240) -> fndpz, xtoaq, hhboca, llsvd
      |uveybq (947) -> ywpjusg, gapjnb, azvke
      |cqbvru (61)
      |saqjax (45)
      |emlqbo (18)
      |jvayv (171) -> daiah, fyjowg
      |dtnaqds (33)
      |rxuwet (92)
      |xnuoisk (64)
      |etmvojh (80)
      |eqnpvwk (36)
      |puyiail (18)
      |ijrzzr (77)
      |jfuxeo (150) -> xgnqi, dfzfwun
      |pzgvsxu (282) -> cltqhc, ruclz, vindom
      |tqpgc (1018) -> bbxbrsh, uwxbv, nlhxju, hazbs
      |nadbbgx (258) -> akoqk, izwze
      |qdwkxia (72)
      |rbqcbvl (88)
      |wutdi (38)
      |mlrjfy (38)
      |efxakc (154) -> dfaro, lcsqgx
      |dacbtyf (57)
      |mevea (303) -> qaxvec, esiwujq, plzfjy
      |dsxhhub (12)
      |wjzyxt (252)
      |pnoxhe (27) -> vjqjwk, enpprra, ftmwqqj
      |kkvkz (71)
      |clfrs (72)
      |zovbvcr (383) -> diyvlug, xhodnx, repak, zjfrc
      |jwjggy (210) -> duvrzrl, zsxbg
      |xjfkrjs (33) -> ibzalz, rxuwet
      |gtvnow (180) -> euvev, kvbdsv
      |etfuhz (123) -> zoicqbj, ajvtdl, wmvht
      |afglbpz (16)
      |nquonb (50) -> avbgwvm, lihivo
      |nbpic (148) -> iuoxs, yxvgj
      |eivrwbt (17) -> yeifw, podcsx, fhoprd, beeeaye
      |gszqlv (38)
      |yhycc (121) -> vwkbje, qzhyumq
      |gjzddf (38)
      |cxpoqyu (72)
      |emdsyso (89)
      |qqpsrts (85) -> doudbv, mmzdk
      |gjwuf (124) -> bjlwfmo, evubadn
      |hkhsc (171) -> ipwxws, yrdgv, ckswvj, yjlrwzu, ptmqo, ojishwt, drzrtpi
      |mwtojre (207) -> hmetm, utbev, wltlu, ictdnyf
      |fqoqkzk (12)
      |nkhzrd (5)
      |enpprra (76)
      |gwcig (75)
      |uqcpah (91)
      |koued (75) -> kxrfley, tjnyo
      |dtxrjg (22)
      |pnkag (93) -> ofoto, zzqwzy, zobjfxe, blutjw, aisfhs, gmoliax
      |iucuw (99) -> gulset, drrjnr
      |fhsecp (17)
      |dgrwv (62)
      |ibzalz (92)
      |tbyihc (73)
      |cleanrs (10)
      |cibfe (27)
      |ycvvjgc (28)
      |dnphyfm (7185) -> mpulnxr, sxegjbz, tklfj
      |xnxdmdb (26)
      |jniisu (34)
      |eaqiocy (93) -> dywjt, kikfs, fpmipcr
      |bugtxto (26)
      |pprkvq (26)
      |myznok (57)
      |iblrer (76)
      |bhmzx (64) -> tgoeoh, ojxyv
      |yibxqhs (52)
      |xoqxrbl (93)
      |hoeqoas (99)
      |oxvfpna (222)
      |okbzzwd (73)
      |yhecio (65)
      |esgqip (62)
      |zwofu (30)
      |nnyqes (49)
      |yydyjr (66)
      |ztzfled (70)
      |yvqasth (1018) -> lfksu, xszci
      |eqbvn (153) -> plhybj, kozgi
      |hqmum (79) -> dfdlzzt, ulndqey, zwjqar, jhxxfq
      |gvayfu (64) -> cfvbuip, rbtvx
      |fsagr (141) -> lugkrb, npqroe
      |pfvpb (44)
      |cvdjts (271) -> zmces, ugkey
      |bcjpzpk (174)
      |jxykl (54)
      |mwdfwe (78)
      |diyvlug (133) -> ddsqd, txeucf
      |wbeizj (35)
      |xxswgx (45)
      |wfdxfxq (676) -> irrpz, wvsspk, dqtthnn
      |lcsqgx (8)
      |lmvmb (93)
      |cyvplfd (14)
      |olkcm (131) -> mkdiuil, msbsjpj
      |kloumi (39)
      |xzwjii (63)
      |zmjfa (82)
      |fakyd (842) -> sgtfap, frbmr, rhchuf
      |jgzvrf (173) -> hspol, vbpde
      |slfile (66)
      |jwpwt (63)
      |xhodnx (67) -> estwket, tjjrys
      |ihrhkj (11)
      |wlkatbq (188)
      |cijfsu (68)
      |ipqjff (62)
      |ztaff (6)
      |eecoekq (41)
      |oaxskk (266) -> azwmkej, rciilr
      |sedysm (49)
      |jhwltnv (19) -> akluijb, zvtxa, pvpmt, bkqexxz
      |xhqgsro (6)
      |bmdxyf (318) -> zgslahq, koued, yzuygum
      |dmyzfr (18)
      |rqrfl (65)
      |clmyzsu (115) -> mlrjfy, xiawjb, kroqr
      |rusayd (901) -> ylkfgx, lxsurts
      |tzdtm (80)
      |dpetvw (71)
      |eccwi (6)
      |wdssrl (75)
      |uofigyp (9)
      |aisfhs (183) -> lylaoh, fujwzoc, kobcmy
      |dcgarog (15)
      |eosuf (69)
      |qeosq (66)
      |itxaax (77)
      |mmzdk (77)
      |dvtdje (40)
      |aumbaa (28)
      |wdivd (26)
      |eemfgbx (17)
      |dlrpnot (62)
      |ugxls (62)
      |qqqsv (98)
      |lfhaqdn (27)
      |qblnh (45)
      |yknwap (98)
      |ipogzy (76)
      |irhxzg (124) -> utwzg, crxnz
      |dtwbpl (50)
      |lqnwffm (94)
      |ygnww (13)
      |xrkca (217) -> xhqgsro, avymjz
      |qrsgca (35)
      |ftgvx (14)
      |fhoaub (35)
      |nuuqqqy (94)
      |ppmvpn (94)
      |kisjb (57)
      |owzybm (91)
      |jwddn (134) -> vfosh, nvdon, kopmae, inhqoxd, xlyvge
      |cnbzj (141) -> kuakyv, vnsrv, ijrzzr, dbrnqc
      |wlleabp (179)
      |lhdhko (66)
      |bbsuv (439) -> ionnpk, etfuhz, mobbhp, exuwhfs
      |umvvwsq (10)
      |eibtll (94)
      |otuwt (35) -> ejwno, zogylog, ooiyeep
      |epqsj (137) -> bugtxto, hsnbry
      |yuepckc (66) -> tqpgc, pstaxvr, owtxsq
      |dhzuvup (76)
      |crfse (238)
      |ibcbvy (6)
      |cefbp (78)
      |uhxjy (63)
      |bponwxc (49)
      |mcxki (29) -> rvcmif, gnozwfo, mevea, vtvku, dmtzxui
      |emqoxss (66) -> tnyjkok, gmpqmio
      |ionnpk (97) -> rqlaf, ktrkhe
      |gasnep (91) -> qgwcfll, nkcet
      |avymjz (6)
      |fetns (37) -> zfmeblt, jtsyj, rdqvi
      |altsh (89) -> zdvai, iybvphk
      |kgjcj (242)
      |bltmlm (93) -> xdlvys, tflulu, xqrmgdk, dnphyfm, kwbni, uplbokf, vbsfwqh
      |hikik (15)
      |nnofr (71) -> xxrsnzv, pucsbv, rtzce, kloumi
      |siflauk (271) -> qckem, tzmes
      |nkcet (95)
      |ijjfn (34)
      |itvizjy (20)
      |numadl (98)
      |jkjsi (98)
      |xaebyo (41) -> svadhfo, hoeqoas
      |yntnjp (68)
      |axgpyq (75)
      |civozek (98)
      |djizg (33)
      |qrtdtt (96)
      |kopmae (13) -> pemna, vuzsg, numadl, wuqbe
      |yztqpc (572) -> xxsivgz, scbycx, jwezuh
      |msbsjpj (96)
      |yjlrwzu (77) -> mbydswv, tfzum, kwhwph
      |tcpqh (15)
      |fkqkfdu (25)
      |vbqtd (86) -> cepddei, rcxtjte, zkibug, wjzyxt, zhgzg
      |wmcusr (14)
      |zrnnyet (731) -> zbqpk, tayyz, usztpox, mewfm
      |yadtxl (73)
      |eqctwan (511) -> zitfb, xjfkrjs, xddom
      |evmuxia (32)
      |lbhxdbr (36)
      |fjvoff (62)
      |wsnqied (20)
      |vftqnj (57) -> dvopaww, hbvvse, plzgfx, jkjsi
      |pwwqvhw (34) -> fgnsyw, pyuuxw, nsbvvsi, imshim
      |hnjbsg (32)
      |pglpu (224) -> oxvfpna, umqrwk, bhmzx
      |etcces (4977) -> eqctwan, jncex, zofljd
      |fmvyjwj (68)
      |lgtffok (509) -> ruild, bxpfop, huqpiix, tgksxw
      |iqmqju (3619) -> oxnfnsv, bngres, zkhll
      |xvcikqe (24)
      |wvpwez (89)
      |saijc (96)
      |aiget (16)
      |fdjhpq (66)
      |adcbil (47)
      |lrnjjfq (17)
      |teastj (53)
      |csybv (33546) -> kdtpg, wseyo, etcces, pnkag
      |zkibug (238) -> xkfps, giblwzi
      |pzahn (73)
      |auzded (499) -> tqeeva, fyrqw, oaxskk, hwsrjah, jfqanu
      |bhthbfj (35)
      |dvkrlzc (22)
      |dgrfhvi (67)
      |qcghv (67) -> ezkqh, uqcpah
      |sdrhiyo (27)
      |kwhwph (69)
      |ejzfwt (52)
      |vuzsg (98)
      |tgoeoh (79)
      |vrpqev (64) -> axlgwj, gfsnsdu, kpdbki, mvqfvit
      |vrydu (43)
      |vnsrv (77)
      |gjfoe (161) -> mcduoz, eccwi
      |ppgaoz (65) -> pejmc, cbwbdsv, otuwt
      |xddom (39) -> aujxmm, fjrpc
      |lxsurts (6)
      |tayyz (50) -> vtzdfjg, ijvux
      |kwzrzn (71)
      |doudbv (77)
      |ahridq (24)
      |dqtthnn (217) -> hgsng, jwzmsv
      |haeymgy (85)
      |zoicqbj (36)
      |bcjxhps (58)
      |swumt (66)
      |iywwyn (43)
      |pirieql (92)
      |ntazqjk (53)
      |ajwxaa (208) -> wtvffu, gmdcbyg, intuzzk
      |wscktm (15)
      |itygd (57)
      |hjzehyw (49)
      |jdmjou (69)
      |iavuhwe (49)
      |tpfuxx (26)
      |wseyo (5904) -> beraoor, zbhwrc, ybnpc
      |rlapq (322) -> adcbil, rbfbf
      |jtsyj (56)
      |zouml (199) -> dmyzfr, udjcwm
      |txrxyqh (107) -> rdufpid, yhunajf, dgsutv
      |zobjfxe (525) -> ylbpwah, nadbbgx, putpp
      |inhqoxd (327) -> cdafdq, zucsr, pprkvq
      |ndajgou (96)
      |paeea (75)
      |yrdgv (284)
      |sbcuc (65)
      |aklrjg (10)
      |kbjnzw (117) -> xtzqooh, lfhaqdn
      |cfafhwl (34)
      |htyeqf (94)
      |dmiqf (62)
      |tghoyv (210) -> iywwyn, gypsfc
      |plxdglq (24)
      |qxwlhxh (41)
      |pknjpc (52)
      |njqzaxg (23) -> saijc, jmbiky
      |tckcxhb (68) -> yfzjc, nwjibjk, igfhu, iryrfjs
      |xdlvys (3528) -> zcjrk, wkrtcw, kuujprz
      |dcngdo (47)
      |pazbvum (57)
      |kvags (67)
      |nuuwbui (35)
      |whcxfwf (115) -> vrydu, ruxuw
      |ojishwt (126) -> llcbiqi, namzy
      |uwxbv (31)
      |vrqeade (102) -> emlqbo, vywqra, upsiumf, blofdav
      |rixge (338)
      |dmtzxui (98) -> auhio, qwddgc, hiqqg, iezdimc
      |texfyi (144)
      |cgwnn (384) -> nioeugr, gjzddf
      |mwzaxaj (59) -> csybv, febjzqn, bltmlm, dfyyjta, ljaktj, vmyda, vbcfe
      |yquqk (83) -> wvjjht, edyqn, frleu, puxaz
      |jaoiiae (81)
      |pucsbv (39)
    """.trim.stripMargin.split("\n").map(_.trim)

  test("Day07.challenge") {
    assert(Day07.findRoot(challengeinput) == "mwzaxaj")
  }

  test("Day07.findImbalance") {
    assert(Day07.findImbalance(testinput) == 60)
  }

  test("Day07.challenge2") {
    assert(Day07.findImbalance(challengeinput) == 1219)
  }
}
