#!/usr/bin/env python
# Licensed to Cloudera, Inc. under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  Cloudera, Inc. licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import logging
import os
import tempfile

from nose.tools import assert_equal

from impala import conf, impala_flags


LOG = logging.getLogger(__name__)


def test_impala_flags():
  test_impala_conf_dir = tempfile.mkdtemp()
  finish = None

  try:
    assert_equal(conf.QUERYCACHE_ROWS.get(), 50000)
    assert_equal(conf.IMPERSONATION_ENABLED.get(), False)

    flags = """
      -webserver_certificate_file=/etc/test-ssl-conf/CA_STANDARD/impala-cert.pem
      -ssl_server_certificate=/etc/test-ssl-conf/CA_STANDARD/impala-cert.pem
      -max_result_cache_size=100000
      -authorized_proxy_user_config=hue=*
    """
    file(os.path.join(test_impala_conf_dir, 'impalad_flags'), 'w').write(flags)

    finish = conf.IMPALA_CONF_DIR.set_for_testing(test_impala_conf_dir)
    impala_flags.reset()

    assert_equal(impala_flags.get_webserver_certificate_file(), '/etc/test-ssl-conf/CA_STANDARD/impala-cert.pem')
    assert_equal(impala_flags.get_ssl_server_certificate(), '/etc/test-ssl-conf/CA_STANDARD/impala-cert.pem')
    assert_equal(impala_flags.get_max_result_cache_size(), 100000)
    assert_equal(impala_flags.get_authorized_proxy_user_config(), 'hue=*')

    # From Config
    assert_equal(conf.QUERYCACHE_ROWS.get(), 100000)
    assert_equal(conf.IMPERSONATION_ENABLED.get(), True)
  finally:
    impala_flags.reset()
    if finish:
      finish()
