/**
 * @license lucide v0.414.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */

import defaultAttributes from '../defaultAttributes.js';

const BatteryWarning = [
  "svg",
  defaultAttributes,
  [
    ["path", { d: "M14 7h2a2 2 0 0 1 2 2v6c0 1-1 2-2 2h-2" }],
    ["path", { d: "M6 7H4a2 2 0 0 0-2 2v6c0 1 1 2 2 2h2" }],
    ["line", { x1: "22", x2: "22", y1: "11", y2: "13" }],
    ["line", { x1: "10", x2: "10", y1: "7", y2: "13" }],
    ["line", { x1: "10", x2: "10", y1: "17", y2: "17.01" }]
  ]
];

export { BatteryWarning as default };
//# sourceMappingURL=battery-warning.js.map
