import cq_queryabolt
from vitamins.vslot import vslot

class Settings:
    tightFit = 0.1
    fit = 0.2
    looseFit = 0.5

    minBoltWallD = 5

    bolt = "M3"
    boltD = cq_queryabolt.boltData(bolt)['diameter']
    boltWallD = boltD + minBoltWallD
    cboreBoltWallD = cq_queryabolt.boltData(bolt, kind="socket_head")['head_diameter'] + minBoltWallD
    nutH = cq_queryabolt.nutData(bolt)['thickness']

    sacrificialLayers = 0.2

    yL = 300

    bedXFrameClearance = 5
    bedY = 140
    bedX = 150
    bedT = 4

    xL = bedX + 2 * vslot.d + 2 * bedXFrameClearance
