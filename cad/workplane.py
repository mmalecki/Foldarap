from settings import Settings
import cadquery as cq
import cq_queryabolt

class Workplane(cq_queryabolt.WorkplaneMixin, cq.Workplane):
    def sacrificialLayer(self, d = Settings.boltD, t = Settings.sacrificialLayers):
        return self.cylinder(t, d / 2, centered=( True, True, False ))

    def zipTieSlot(self, rot = 0):
        return self.slot2D(Settings.zipTieL, Settings.zipTieD, rot)
