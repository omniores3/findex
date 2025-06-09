/**
 * @license lucide v0.414.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */

import defaultAttributes from '../defaultAttributes.js';

const MoveDiagonal = [
  "svg",
  defaultAttributes,
  [
    ["polyline", { points: "13 5 19 5 19 11" }],
    ["polyline", { points: "11 19 5 19 5 13" }],
    ["line", { x1: "19", x2: "5", y1: "5", y2: "19" }]
  ]
];

export { MoveDiagonal as default };
//# sourceMappingURL=move-diagonal.js.map
