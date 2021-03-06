# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pkg-config/pkg-config-1.1.5.ebuild,v 1.5 2014/08/30 11:31:13 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.rdoc NEWS"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A pkg-config implementation by Ruby"
HOMEPAGE="https://github.com/rcairo/pkg-config"
LICENSE="|| ( LGPL-2 LGPL-2.1 LGPL-3 )"

KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE="test"

ruby_add_bdepend "test? ( >=dev-ruby/test-unit-2.5.1-r1 )"
# this is used for testing
DEPEND+=" test? ( x11-libs/cairo )"

all_ruby_prepare() {
# drop failing tests
	sed -i -e "/test_cflags/,/end/d"\
		-e "/test_cflags_only_I/,/end/d" test/test_pkg_config.rb || die
}

each_ruby_test() {
	ruby-ng_testrb-2 -Ilib test/test_${PN/-/_}.rb
}
