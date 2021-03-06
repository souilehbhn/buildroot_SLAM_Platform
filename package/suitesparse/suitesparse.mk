################################################################################
#
# SuiteSparse
#
################################################################################

SUITESPARSE_VERSION = 5.4.0
SUITESPARSE_SOURCE = SuiteSparse-$(SUITESPARSE_VERSION).tar.gz
SUITESPARSE_SITE = http://faculty.cse.tamu.edu/davis/SuiteSparse
SUITESPARSE_INSTALL_STAGING = YES
SUITESPARSE_LICENSE_FILES = INSTALL.txt
SUITESPARSE_DEPENDENCIES = clapack

define SSCONFIG_BUILD_CMDS
	( cd $(@D)/SuiteSparse_config && $(MAKE) $(TARGET_CONFIGURE_OPTS) BLAS=-lblas )
endef

define SSCONFIG_INSTALL_STAGING_CMDS
	( cd $(@D)/SuiteSparse_config && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(STAGING_DIR)/usr/ )
endef

define SSCONFIG_INSTALL_TARGET_CMDS
	( cd $(@D)/SuiteSparse_config && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(TARGET_DIR)/usr/ )
endef


ifeq ($(BR2_PACKAGE_SUITESPARSE_METIS),y)
define METIS_BUILD_CMDS 
	( cd $(@D)/metis-5.1.0 && $(MAKE) $(TARGET_CONFIGURE_OPTS) config shared=1 prefix=$(@D) )
	( cd $(@D)/metis-5.1.0 && $(MAKE) $(TARGET_CONFIGURE_OPTS) )
	( cd $(@D)/metis-5.1.0 && $(MAKE) $(TARGET_CONFIGURE_OPTS) install )
endef

define METIS_INSTALL_STAGING_CMDS 
	@mkdir -p $(STAGING_DIR)/usr/lib
	@mkdir -p $(STAGING_DIR)/usr/include
	cp $(@D)/lib/libmetis.* $(STAGING_DIR)/usr/lib
	cp $(@D)/include/metis.h $(STAGING_DIR)/usr/include
	chmod 755 $(STAGING_DIR)/usr/lib/libmetis.*
	chmod 644 $(STAGING_DIR)/usr/include/metis.h
endef

define METIS_INSTALL_TARGET_CMDS 
	@mkdir -p $(TARGET_DIR)/usr/lib
	@mkdir -p $(TARGET_DIR)/usr/include
	cp $(@D)/lib/libmetis.* $(TARGET_DIR)/usr/lib
	cp $(@D)/include/metis.h $(TARGET_DIR)/usr/include
	chmod 755 $(TARGET_DIR)/usr/lib/libmetis.*
	chmod 644 $(TARGET_DIR)/usr/include/metis.h
endef
endif

ifeq ($(BR2_PACKAGE_SUITESPARSE_AMD),y)

define AMD_BUILD_CMDS
	( cd $(@D)/AMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS=-L$(@D)/lib library )
endef
define AMD_INSTALL_STAGING_CMDS
	( cd $(@D)/AMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(STAGING_DIR)/usr/ )
endef
define AMD_INSTALL_TARGET_CMDS
	( cd $(@D)/AMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(TARGET_DIR)/usr/ )
endef
endif
ifeq ($(BR2_PACKAGE_SUITESPARSE_CAMD),y)

define CAMD_BUILD_CMDS
	( cd $(@D)/CAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS=-L$(@D)/lib library )
endef
define CAMD_INSTALL_STAGING_CMDS
	( cd $(@D)/CAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(STAGING_DIR)/usr/ )
endef
define CAMD_INSTALL_TARGET_CMDS
	( cd $(@D)/CAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(TARGET_DIR)/usr/ )
endef
endif
ifeq ($(BR2_PACKAGE_SUITESPARSE_CCOLAMD),y)

define CCOLAMD_BUILD_CMDS
	( cd $(@D)/CCOLAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS=-L$(@D)/lib library )
endef
define CCOLAMD_INSTALL_STAGING_CMDS
	( cd $(@D)/CCOLAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(STAGING_DIR)/usr/ )
endef
define CCOLAMD_INSTALL_TARGET_CMDS
	( cd $(@D)/CCOLAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(TARGET_DIR)/usr/ )
endef
endif
ifeq ($(BR2_PACKAGE_SUITESPARSE_COLAMD),y)

define COLAMD_BUILD_CMDS
	( cd $(@D)/COLAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS=-L$(@D)/lib library INSTALL=$(STAGING_DIR)/usr )
endef
define COLAMD_INSTALL_STAGING_CMDS
	( cd $(@D)/COLAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(STAGING_DIR)/usr/ )
endef
define COLAMD_INSTALL_TARGET_CMDS
	( cd $(@D)/COLAMD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(TARGET_DIR)/usr/ )
endef
endif
ifeq ($(BR2_PACKAGE_SUITESPARSE_CHOLMOD),y)

define CHOLMOD_BUILD_CMDS
	( cd $(@D)/CHOLMOD && $(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS=-L$(@D)/lib library INSTALL=$(STAGING_DIR)/usr BLAS=-lblas )
endef
define CHOLMOD_INSTALL_STAGING_CMDS
	( cd $(@D)/CHOLMOD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(STAGING_DIR)/usr/ BLAS=-lblas)
endef
define CHOLMOD_INSTALL_TARGET_CMDS
	( cd $(@D)/CHOLMOD && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(TARGET_DIR)/usr/ BLAS=-lblas)
endef
endif
ifeq ($(BR2_PACKAGE_SUITESPARSE_CXSPARSE),y)

define CXSPARSE_BUILD_CMDS
	( cd $(@D)/CXSparse && $(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS=-L$(@D)/lib library BLAS=-lblas)
endef
define CXSPARSE_INSTALL_STAGING_CMDS
	( cd $(@D)/CXSparse && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(STAGING_DIR)/usr/ )
endef
define CXSPARSE_INSTALL_TARGET_CMDS
	( cd $(@D)/CXSparse && $(MAKE) $(TARGET_CONFIGURE_OPTS) install INSTALL=$(TARGET_DIR)/usr/ )
endef
endif

define SUITESPARSE_BUILD_CMDS
	$(SSCONFIG_BUILD_CMDS)
	$(METIS_BUILD_CMDS)
	$(AMD_BUILD_CMDS)
	$(CAMD_BUILD_CMDS)
	$(CCOLAMD_BUILD_CMDS)
	$(COLAMD_BUILD_CMDS)
	$(CHOLMOD_BUILD_CMDS)
	$(CXSPARSE_BUILD_CMDS)
endef

define SUITESPARSE_INSTALL_STAGING_CMDS
	$(SSCONFIG_INSTALL_STAGING_CMDS)
	$(METIS_INSTALL_STAGING_CMDS)
	$(AMD_INSTALL_STAGING_CMDS)
	$(CAMD_INSTALL_STAGING_CMDS)
	$(CCOLAMD_INSTALL_STAGING_CMDS)
	$(COLAMD_INSTALL_STAGING_CMDS)
	$(CHOLMOD_INSTALL_STAGING_CMDS)
	$(CXSPARSE_INSTALL_STAGING_CMDS)
endef

define SUITESPARSE_INSTALL_TARGET_CMDS
	$(SSCONFIG_INSTALL_TARGET_CMDS)
	$(METIS_INSTALL_TARGET_CMDS)
	$(AMD_INSTALL_TARGET_CMDS)
	$(CAMD_INSTALL_TARGET_CMDS)
	$(CCOLAMD_INSTALL_TARGET_CMDS)
	$(COLAMD_INSTALL_TARGET_CMDS)
	$(CHOLMOD_INSTALL_TARGET_CMDS)
	$(CXSPARSE_INSTALL_TARGET_CMDS)
endef

$(eval $(generic-package))
