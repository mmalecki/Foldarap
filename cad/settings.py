from dataclasses import dataclass
import cq_queryabolt
from vitamins.vslot import vslot

_belts = {
    'GT2': {
        'thickness': 2,
        'width': 6
    }
}

_idlers = {
    'GT2-16T': {
        'diameter': 14,
        'height': 9
    }
}

@dataclass
class Belt:
    thickness: float
    width: float

@dataclass
class Idler:
    diameter: float
    height: float

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

    frameBolt = "M4"
    frameBoltD = cq_queryabolt.boltData(frameBolt)['diameter']
    frameBoltWallD = frameBoltD + minBoltWallD

    # Thickness of a plate upon which stepper-like forces act.
    stepperPlateT = 5

    sacrificialLayers = 0.2

    yL = 300

    bedXFrameClearance = 5
    bedY = 140
    bedX = 150
    bedT = 4

    xL = bedX + 2 * vslot.d + 2 * bedXFrameClearance

    belt = Belt(**_belts['GT2'])
    yIdler = Idler(**_idlers['GT2-16T'])

