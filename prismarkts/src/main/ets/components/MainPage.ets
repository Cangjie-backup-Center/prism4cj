import { CustomLib, PrismNodesParseResColorArkts } from "libark_interop_api.so";
import { requireCJLib } from "libark_interop_loader.so";

export function codeStringToColorString(code: string, info: string | undefined,
  isDarkula: boolean): PrismNodesParseResColorArkts {
  let lib = requireCJLib("libprism4cj.so") as CustomLib
  return lib.codeStringToColorStringArkts(code, info, isDarkula)
}
