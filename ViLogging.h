//
//  ViLogging.h
//  Visionscapers core library
//
//  Created by Freddy Snijder on 14/09/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#ifndef ViLogging_h
#define ViLogging_h

#import "LibComponentLogging-Core/lcl.h"

//DEFINE MACRO _LCL_NO_LOGGING IN YOUR (RELEASE) BUILD SETTINGS TO STRIP ALL LOGGING

#define LOG_CRITICAL_ONLY           lcl_configure_by_identifier("*",lcl_vCritical);
#define LOG_ERRORS_AND_HIGHER       lcl_configure_by_identifier("*",lcl_vError);
#define LOG_WARNINGS_AND_HIGHER     lcl_configure_by_identifier("*",lcl_vWarning);
#define LOG_INFO_AND_HIGHER         lcl_configure_by_identifier("*",lcl_vInfo);
#define LOG_EVERYTHING              lcl_configure_by_identifier("*",lcl_vTrace);


//IMPORTANT : _format, must really be a format string. Even if you don't need formating use
// _LOG_XYZ("%@", "someting I want to log")

#define _LOG_CRITICAL(_format, ...) lcl_log(lcl_cViDefault, lcl_vCritical, _format, ## __VA_ARGS__)
#define _LOG_ERROR(_format, ...)    lcl_log(lcl_cViDefault, lcl_vError, _format, ## __VA_ARGS__)
#define _LOG_WARN(_format, ...)     lcl_log(lcl_cViDefault, lcl_vWarning, _format, ## __VA_ARGS__)
#define _LOG_INFO(_format, ...)     lcl_log(lcl_cViDefault, lcl_vInfo, _format, ## __VA_ARGS__)
#define _LOG_DEBUG(_format, ...)    lcl_log(lcl_cViDefault, lcl_vDebug, _format, ## __VA_ARGS__)
#define _LOG_TRACE(_format, ...)    lcl_log(lcl_cViDefault, lcl_vTrace, _format, ## __VA_ARGS__)


#endif
