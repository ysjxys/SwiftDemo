/**
 * Created by BeeHive.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#ifndef XGCommon_h
#define XGCommon_h

// Debug Logging
#ifdef DEBUG
#define XGLog(x, ...) NSLog(x, ## __VA_ARGS__);
#else
#define XGLog(x, ...)
#endif

#endif /* XGCommon_h */
