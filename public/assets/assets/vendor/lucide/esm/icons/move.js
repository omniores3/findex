/**
 * @license lucide v0.414.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */

import defaultAttributes from '../defaultAttributes.js';

const Move = [
  "svg",
  defaultAttributes,
  [
    ["polyline", { points: "5 9 2 12 5 15" }],
    ["polyline", { points: "9 5 12 2 15 5" }],
    ["polyline", { points: "15 19 12 22 9 19" }],
    ["polyline", { points: "19 9 22 12 19 15" }],
    ["line", { x1: "2", x2: "22", y1: "12", y2: "12" }],
    ["line", { x1: "12", x2: "12", y1: "2", y2: "22" }]
  ]
];

export { Move as default };
//# sourceMappingURL=move.js.map
