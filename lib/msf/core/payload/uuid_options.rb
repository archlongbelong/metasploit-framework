# -*- coding => binary -*-

require 'msf/core'
require 'msf/core/payload/uuid'
require 'rex/payloads/meterpreter/uri_checksum.rb'

#
# This module provides datastore option definitions and helper methods for payload modules that support UUIDs
#
module Msf::Payload::UUIDOptions

  include Rex::Payloads::Meterpreter::UriChecksum

  def initialize(info = {})
    super
    register_advanced_options(
      [
        Msf::OptString.new('PayloadUUIDSeed', [ false, 'A string to use when generating the payload UUID (deterministic)']),
        Msf::OptString.new('PayloadUUIDRaw', [ false, 'A hex string representing the raw 8-byte PUID value for the UUID']),
      ], self.class)
  end

  #
  # Generates a URI with a given checksum and optionally with an embedded UUID if
  # the desired length can accomodate it.
  #
  # @param mode [Symbol] The type of checksum to generate (:connect, :init_native, :init_python, :init_java)
  # @param len [Fixnum] The length of the URI not including the leading slash, optionally nil for random
  # @return [String] A URI with a leading slash that hashes to the checksum, with an optional UUID
  #
  def generate_uri_uuid_mode(mode,len=nil)
    sum = uri_checksum_lookup(mode)

    # The URI length may not have room for an embedded checksum
    if len && len < URI_CHECKSUM_UUID_MIN_LEN
      # Throw an error if the user set a seed, but there is no room for it
      if datastore['PayloadUUIDSeed'].to_s.length > 0 ||datastore['PayloadUUIDRaw'].to_s.length > 0
        raise ArgumentError, "A PayloadUUIDSeed or PayloadUUIDRaw value was specified, but this payload doesn't have enough room for a UUID"
      end
      return "/" + generate_uri_checksum(sum, len, prefix="")
    end

    generate_uri_uuid(sum, generate_payload_uuid, len)
  end

  # Generate a Payload UUID
  def generate_payload_uuid

    conf = {
      arch:     self.arch,
      platform: self.platform
    }

    # Handle user-specified seed values
    if datastore['PayloadUUIDSeed'].to_s.length > 0
      conf[:seed] = datastore['PayloadUUIDSeed'].to_s
    end

    # Handle user-specified raw payload UID values
    if datastore['PayloadUUIDRaw'].to_s.length > 0
      puid_raw = [datastore['PayloadUUIDRaw'].to_s].pack("H*")
      if puid_raw.length != 8
        raise ArgumentError, "The PayloadUUIDRaw value must be exactly 16 bytes of hex"
      end
      conf.delete(:seed)
      conf[:puid] = puid_raw
    end

    Msf::Payload::UUID.new(conf)
  end

end

