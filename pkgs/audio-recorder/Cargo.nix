# Generated by carnix 0.9.8: carnix generate-nix --src ./.
{ lib, buildPlatform, buildRustCrate, buildRustCrateHelpers, cratesIO, fetchgit }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {
  crates = cratesIO // rec {
# alsa-0.2.0

    crates.alsa."0.2.0" = deps: { features?(features_.alsa."0.2.0" deps {}) }: buildRustCrate {
      crateName = "alsa";
      version = "0.2.0";
      authors = [ "David Henningsson <diwic@ubuntu.com>" ];
      src = fetchgit {
         url = "https://github.com/lopsided98/alsa-rs";
         rev = "fba9af35998a8e663c172d535757dde5a17d5576";
         sha256 = "0agf1hnw0ybvbvv5mna208s4mf3vxsbvxc1lcpcgv0ksklz5qnhi";
         fetchSubmodules = false;
      };
      dependencies = mapFeatures features ([
        (crates."alsa_sys"."${deps."alsa"."0.2.0"."alsa_sys"}" deps)
        (cratesIO.crates."bitflags"."${deps."alsa"."0.2.0"."bitflags"}" deps)
        (cratesIO.crates."libc"."${deps."alsa"."0.2.0"."libc"}" deps)
        (cratesIO.crates."nix"."${deps."alsa"."0.2.0"."nix"}" deps)
      ]);
    };
    features_.alsa."0.2.0" = deps: f: updateFeatures f (rec {
      alsa."0.2.0".default = (f.alsa."0.2.0".default or true);
      alsa_sys."${deps.alsa."0.2.0".alsa_sys}".default = true;
      bitflags."${deps.alsa."0.2.0".bitflags}".default = true;
      libc."${deps.alsa."0.2.0".libc}".default = true;
      nix."${deps.alsa."0.2.0".nix}".default = true;
    }) [
      (features_.alsa_sys."${deps."alsa"."0.2.0"."alsa_sys"}" deps)
      (cratesIO.features_.bitflags."${deps."alsa"."0.2.0"."bitflags"}" deps)
      (cratesIO.features_.libc."${deps."alsa"."0.2.0"."libc"}" deps)
      (cratesIO.features_.nix."${deps."alsa"."0.2.0"."nix"}" deps)
    ];


# end
# alsa-sys-0.1.2

    crates.alsa_sys."0.1.2" = deps: { features?(features_.alsa_sys."0.1.2" deps {}) }: buildRustCrate {
      crateName = "alsa-sys";
      version = "0.1.2";
      authors = [ "Pierre Krieger <pierre.krieger1708@gmail.com>" "David Henningsson <diwic@ubuntu.com>" ];
      src = fetchgit {
         url = "https://github.com/lopsided98/alsa-sys.git";
         rev = "8e1db5c61e38f8690cd11cff8a61e6983f586f58";
         sha256 = "007vsnjfz23hvb4nvsdb7sg757m2g2hb6yf1fc87d4c5ywpr5348";
         fetchSubmodules = false;
      };
      build = "build.rs";
      dependencies = mapFeatures features ([
        (cratesIO.crates."libc"."${deps."alsa_sys"."0.1.2"."libc"}" deps)
      ]);

      buildDependencies = mapFeatures features ([
        (cratesIO.crates."pkg_config"."${deps."alsa_sys"."0.1.2"."pkg_config"}" deps)
      ]);
    };
    features_.alsa_sys."0.1.2" = deps: f: updateFeatures f (rec {
      alsa_sys."0.1.2".default = (f.alsa_sys."0.1.2".default or true);
      libc."${deps.alsa_sys."0.1.2".libc}".default = true;
      pkg_config."${deps.alsa_sys."0.1.2".pkg_config}".default = true;
    }) [
      (cratesIO.features_.libc."${deps."alsa_sys"."0.1.2"."libc"}" deps)
      (cratesIO.features_.pkg_config."${deps."alsa_sys"."0.1.2"."pkg_config"}" deps)
    ];


# end
# audio_server-0.3.0

    crates.audio_server."0.3.0" = deps: { features?(features_.audio_server."0.3.0" deps {}) }: buildRustCrate {
      crateName = "audio_server";
      version = "0.3.0";
      authors = [ "Ben Wolsieffer <benwolsieffer@gmail.com>" ];
      edition = "2018";
      src = exclude [ ".git" "target" ] ./.;
      dependencies = mapFeatures features ([
        (crates."alsa"."${deps."audio_server"."0.3.0"."alsa"}" deps)
        (cratesIO.crates."env_logger"."${deps."audio_server"."0.3.0"."env_logger"}" deps)
        (cratesIO.crates."failure"."${deps."audio_server"."0.3.0"."failure"}" deps)
        (cratesIO.crates."failure_derive"."${deps."audio_server"."0.3.0"."failure_derive"}" deps)
        (cratesIO.crates."futures"."${deps."audio_server"."0.3.0"."futures"}" deps)
        (cratesIO.crates."grpcio"."${deps."audio_server"."0.3.0"."grpcio"}" deps)
        (cratesIO.crates."hostname"."${deps."audio_server"."0.3.0"."hostname"}" deps)
        (cratesIO.crates."hound"."${deps."audio_server"."0.3.0"."hound"}" deps)
        (cratesIO.crates."libc"."${deps."audio_server"."0.3.0"."libc"}" deps)
        (cratesIO.crates."log"."${deps."audio_server"."0.3.0"."log"}" deps)
        (cratesIO.crates."mio"."${deps."audio_server"."0.3.0"."mio"}" deps)
        (cratesIO.crates."nix"."${deps."audio_server"."0.3.0"."nix"}" deps)
        (cratesIO.crates."protobuf"."${deps."audio_server"."0.3.0"."protobuf"}" deps)
        (cratesIO.crates."regex"."${deps."audio_server"."0.3.0"."regex"}" deps)
        (cratesIO.crates."serde"."${deps."audio_server"."0.3.0"."serde"}" deps)
        (cratesIO.crates."serde_derive"."${deps."audio_server"."0.3.0"."serde_derive"}" deps)
        (cratesIO.crates."serde_yaml"."${deps."audio_server"."0.3.0"."serde_yaml"}" deps)
        (cratesIO.crates."tokio"."${deps."audio_server"."0.3.0"."tokio"}" deps)
        (cratesIO.crates."tokio_process"."${deps."audio_server"."0.3.0"."tokio_process"}" deps)
        (cratesIO.crates."tokio_threadpool"."${deps."audio_server"."0.3.0"."tokio_threadpool"}" deps)
      ]);

      buildDependencies = mapFeatures features ([
        (cratesIO.crates."protoc_grpcio"."${deps."audio_server"."0.3.0"."protoc_grpcio"}" deps)
      ]);
    };
    features_.audio_server."0.3.0" = deps: f: updateFeatures f (rec {
      alsa."${deps.audio_server."0.3.0".alsa}".default = true;
      audio_server."0.3.0".default = (f.audio_server."0.3.0".default or true);
      env_logger."${deps.audio_server."0.3.0".env_logger}".default = true;
      failure."${deps.audio_server."0.3.0".failure}".default = true;
      failure_derive."${deps.audio_server."0.3.0".failure_derive}".default = true;
      futures."${deps.audio_server."0.3.0".futures}".default = true;
      grpcio = fold recursiveUpdate {} [
        { "${deps.audio_server."0.3.0".grpcio}"."protobuf-codec" = true; }
        { "${deps.audio_server."0.3.0".grpcio}".default = (f.grpcio."${deps.audio_server."0.3.0".grpcio}".default or false); }
      ];
      hostname."${deps.audio_server."0.3.0".hostname}".default = true;
      hound."${deps.audio_server."0.3.0".hound}".default = true;
      libc."${deps.audio_server."0.3.0".libc}".default = true;
      log."${deps.audio_server."0.3.0".log}".default = true;
      mio."${deps.audio_server."0.3.0".mio}".default = true;
      nix."${deps.audio_server."0.3.0".nix}".default = true;
      protobuf."${deps.audio_server."0.3.0".protobuf}".default = true;
      protoc_grpcio."${deps.audio_server."0.3.0".protoc_grpcio}".default = true;
      regex."${deps.audio_server."0.3.0".regex}".default = true;
      serde."${deps.audio_server."0.3.0".serde}".default = true;
      serde_derive."${deps.audio_server."0.3.0".serde_derive}".default = true;
      serde_yaml."${deps.audio_server."0.3.0".serde_yaml}".default = true;
      tokio."${deps.audio_server."0.3.0".tokio}".default = true;
      tokio_process."${deps.audio_server."0.3.0".tokio_process}".default = true;
      tokio_threadpool."${deps.audio_server."0.3.0".tokio_threadpool}".default = true;
    }) [
      (features_.alsa."${deps."audio_server"."0.3.0"."alsa"}" deps)
      (cratesIO.features_.env_logger."${deps."audio_server"."0.3.0"."env_logger"}" deps)
      (cratesIO.features_.failure."${deps."audio_server"."0.3.0"."failure"}" deps)
      (cratesIO.features_.failure_derive."${deps."audio_server"."0.3.0"."failure_derive"}" deps)
      (cratesIO.features_.futures."${deps."audio_server"."0.3.0"."futures"}" deps)
      (cratesIO.features_.grpcio."${deps."audio_server"."0.3.0"."grpcio"}" deps)
      (cratesIO.features_.hostname."${deps."audio_server"."0.3.0"."hostname"}" deps)
      (cratesIO.features_.hound."${deps."audio_server"."0.3.0"."hound"}" deps)
      (cratesIO.features_.libc."${deps."audio_server"."0.3.0"."libc"}" deps)
      (cratesIO.features_.log."${deps."audio_server"."0.3.0"."log"}" deps)
      (cratesIO.features_.mio."${deps."audio_server"."0.3.0"."mio"}" deps)
      (cratesIO.features_.nix."${deps."audio_server"."0.3.0"."nix"}" deps)
      (cratesIO.features_.protobuf."${deps."audio_server"."0.3.0"."protobuf"}" deps)
      (cratesIO.features_.regex."${deps."audio_server"."0.3.0"."regex"}" deps)
      (cratesIO.features_.serde."${deps."audio_server"."0.3.0"."serde"}" deps)
      (cratesIO.features_.serde_derive."${deps."audio_server"."0.3.0"."serde_derive"}" deps)
      (cratesIO.features_.serde_yaml."${deps."audio_server"."0.3.0"."serde_yaml"}" deps)
      (cratesIO.features_.tokio."${deps."audio_server"."0.3.0"."tokio"}" deps)
      (cratesIO.features_.tokio_process."${deps."audio_server"."0.3.0"."tokio_process"}" deps)
      (cratesIO.features_.tokio_threadpool."${deps."audio_server"."0.3.0"."tokio_threadpool"}" deps)
      (cratesIO.features_.protoc_grpcio."${deps."audio_server"."0.3.0"."protoc_grpcio"}" deps)
    ];


# end

  };

  audio_server = crates.crates.audio_server."0.3.0" deps;
  __all = [ (audio_server {}) ];
  deps.aho_corasick."0.6.10" = {
    memchr = "2.2.0";
  };
  deps.alsa."0.2.0" = {
    alsa_sys = "0.1.2";
    bitflags = "0.9.1";
    libc = "0.2.50";
    nix = "0.9.0";
  };
  deps.alsa_sys."0.1.2" = {
    libc = "0.2.50";
    pkg_config = "0.3.14";
  };
  deps.arc_swap."0.3.7" = {};
  deps.arrayvec."0.4.10" = {
    nodrop = "0.1.13";
  };
  deps.atty."0.2.11" = {
    termion = "1.5.1";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.audio_server."0.3.0" = {
    alsa = "0.2.0";
    env_logger = "0.6.1";
    failure = "0.1.5";
    failure_derive = "0.1.5";
    futures = "0.1.25";
    grpcio = "0.4.4";
    hostname = "0.1.5";
    hound = "3.4.0";
    libc = "0.2.50";
    log = "0.4.6";
    mio = "0.6.16";
    nix = "0.9.0";
    protobuf = "2.4.0";
    regex = "1.1.2";
    serde = "1.0.89";
    serde_derive = "1.0.89";
    serde_yaml = "0.8.8";
    tokio = "0.1.17";
    tokio_process = "0.2.3";
    tokio_threadpool = "0.1.12";
    protoc_grpcio = "0.3.1";
  };
  deps.autocfg."0.1.2" = {};
  deps.backtrace."0.3.14" = {
    cfg_if = "0.1.7";
    rustc_demangle = "0.1.13";
    autocfg = "0.1.2";
    backtrace_sys = "0.1.28";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.backtrace_sys."0.1.28" = {
    libc = "0.2.50";
    cc = "1.0.31";
  };
  deps.bitflags."0.9.1" = {};
  deps.bitflags."1.0.4" = {};
  deps.byteorder."1.3.1" = {};
  deps.bytes."0.4.12" = {
    byteorder = "1.3.1";
    iovec = "0.1.2";
  };
  deps.cc."1.0.31" = {};
  deps.cfg_if."0.1.7" = {};
  deps.cloudabi."0.0.3" = {
    bitflags = "1.0.4";
  };
  deps.cmake."0.1.35" = {
    cc = "1.0.31";
  };
  deps.crossbeam_deque."0.7.1" = {
    crossbeam_epoch = "0.7.1";
    crossbeam_utils = "0.6.5";
  };
  deps.crossbeam_epoch."0.7.1" = {
    arrayvec = "0.4.10";
    cfg_if = "0.1.7";
    crossbeam_utils = "0.6.5";
    lazy_static = "1.3.0";
    memoffset = "0.2.1";
    scopeguard = "0.3.3";
  };
  deps.crossbeam_queue."0.1.2" = {
    crossbeam_utils = "0.6.5";
  };
  deps.crossbeam_utils."0.6.5" = {
    cfg_if = "0.1.7";
    lazy_static = "1.3.0";
  };
  deps.dtoa."0.4.3" = {};
  deps.env_logger."0.6.1" = {
    atty = "0.2.11";
    humantime = "1.2.0";
    log = "0.4.6";
    regex = "1.1.2";
    termcolor = "1.0.4";
  };
  deps.failure."0.1.5" = {
    backtrace = "0.3.14";
    failure_derive = "0.1.5";
  };
  deps.failure_derive."0.1.5" = {
    proc_macro2 = "0.4.27";
    quote = "0.6.11";
    syn = "0.15.29";
    synstructure = "0.10.1";
  };
  deps.fnv."1.0.6" = {};
  deps.fuchsia_cprng."0.1.1" = {};
  deps.fuchsia_zircon."0.3.3" = {
    bitflags = "1.0.4";
    fuchsia_zircon_sys = "0.3.3";
  };
  deps.fuchsia_zircon_sys."0.3.3" = {};
  deps.futures."0.1.25" = {};
  deps.grpcio."0.4.4" = {
    futures = "0.1.25";
    grpcio_sys = "0.4.4";
    libc = "0.2.50";
    log = "0.4.6";
    protobuf = "2.4.0";
  };
  deps.grpcio_compiler."0.4.3" = {
    protobuf = "2.4.0";
    protobuf_codegen = "2.4.0";
  };
  deps.grpcio_sys."0.4.4" = {
    libc = "0.2.50";
    cc = "1.0.31";
    cmake = "0.1.35";
    pkg_config = "0.3.14";
  };
  deps.hostname."0.1.5" = {
    libc = "0.2.50";
    winutil = "0.1.1";
  };
  deps.hound."3.4.0" = {};
  deps.humantime."1.2.0" = {
    quick_error = "1.2.2";
  };
  deps.iovec."0.1.2" = {
    libc = "0.2.50";
    winapi = "0.2.8";
  };
  deps.kernel32_sys."0.2.2" = {
    winapi = "0.2.8";
    winapi_build = "0.1.1";
  };
  deps.lazy_static."1.3.0" = {};
  deps.lazycell."1.2.1" = {};
  deps.libc."0.2.50" = {};
  deps.linked_hash_map."0.5.1" = {};
  deps.lock_api."0.1.5" = {
    owning_ref = "0.4.0";
    scopeguard = "0.3.3";
  };
  deps.log."0.4.6" = {
    cfg_if = "0.1.7";
  };
  deps.memchr."2.2.0" = {};
  deps.memoffset."0.2.1" = {};
  deps.mio."0.6.16" = {
    iovec = "0.1.2";
    lazycell = "1.2.1";
    log = "0.4.6";
    net2 = "0.2.33";
    slab = "0.4.2";
    fuchsia_zircon = "0.3.3";
    fuchsia_zircon_sys = "0.3.3";
    libc = "0.2.50";
    kernel32_sys = "0.2.2";
    miow = "0.2.1";
    winapi = "0.2.8";
  };
  deps.mio_named_pipes."0.1.6" = {
    log = "0.4.6";
    mio = "0.6.16";
    miow = "0.3.3";
    winapi = "0.3.6";
  };
  deps.mio_uds."0.6.7" = {
    iovec = "0.1.2";
    libc = "0.2.50";
    mio = "0.6.16";
  };
  deps.miow."0.2.1" = {
    kernel32_sys = "0.2.2";
    net2 = "0.2.33";
    winapi = "0.2.8";
    ws2_32_sys = "0.2.1";
  };
  deps.miow."0.3.3" = {
    socket2 = "0.3.8";
    winapi = "0.3.6";
  };
  deps.net2."0.2.33" = {
    cfg_if = "0.1.7";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.nix."0.9.0" = {
    bitflags = "0.9.1";
    cfg_if = "0.1.7";
    libc = "0.2.50";
    void = "1.0.2";
  };
  deps.nodrop."0.1.13" = {};
  deps.num_cpus."1.10.0" = {
    libc = "0.2.50";
  };
  deps.owning_ref."0.4.0" = {
    stable_deref_trait = "1.1.1";
  };
  deps.parking_lot."0.7.1" = {
    lock_api = "0.1.5";
    parking_lot_core = "0.4.0";
  };
  deps.parking_lot_core."0.4.0" = {
    rand = "0.6.5";
    smallvec = "0.6.9";
    rustc_version = "0.2.3";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.pkg_config."0.3.14" = {};
  deps.proc_macro2."0.4.27" = {
    unicode_xid = "0.1.0";
  };
  deps.protobuf."2.4.0" = {};
  deps.protobuf_codegen."2.4.0" = {
    protobuf = "2.4.0";
  };
  deps.protoc."2.4.0" = {
    log = "0.4.6";
  };
  deps.protoc_grpcio."0.3.1" = {
    failure = "0.1.5";
    grpcio_compiler = "0.4.3";
    protobuf = "2.4.0";
    protobuf_codegen = "2.4.0";
    protoc = "2.4.0";
    tempfile = "3.0.7";
  };
  deps.quick_error."1.2.2" = {};
  deps.quote."0.6.11" = {
    proc_macro2 = "0.4.27";
  };
  deps.rand."0.6.5" = {
    rand_chacha = "0.1.1";
    rand_core = "0.4.0";
    rand_hc = "0.1.0";
    rand_isaac = "0.1.1";
    rand_jitter = "0.1.3";
    rand_os = "0.1.3";
    rand_pcg = "0.1.2";
    rand_xorshift = "0.1.1";
    autocfg = "0.1.2";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.rand_chacha."0.1.1" = {
    rand_core = "0.3.1";
    autocfg = "0.1.2";
  };
  deps.rand_core."0.3.1" = {
    rand_core = "0.4.0";
  };
  deps.rand_core."0.4.0" = {};
  deps.rand_hc."0.1.0" = {
    rand_core = "0.3.1";
  };
  deps.rand_isaac."0.1.1" = {
    rand_core = "0.3.1";
  };
  deps.rand_jitter."0.1.3" = {
    rand_core = "0.4.0";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.rand_os."0.1.3" = {
    rand_core = "0.4.0";
    rdrand = "0.4.0";
    cloudabi = "0.0.3";
    fuchsia_cprng = "0.1.1";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.rand_pcg."0.1.2" = {
    rand_core = "0.4.0";
    autocfg = "0.1.2";
  };
  deps.rand_xorshift."0.1.1" = {
    rand_core = "0.3.1";
  };
  deps.rdrand."0.4.0" = {
    rand_core = "0.3.1";
  };
  deps.redox_syscall."0.1.51" = {};
  deps.redox_termios."0.1.1" = {
    redox_syscall = "0.1.51";
  };
  deps.regex."1.1.2" = {
    aho_corasick = "0.6.10";
    memchr = "2.2.0";
    regex_syntax = "0.6.5";
    thread_local = "0.3.6";
    utf8_ranges = "1.0.2";
  };
  deps.regex_syntax."0.6.5" = {
    ucd_util = "0.1.3";
  };
  deps.remove_dir_all."0.5.1" = {
    winapi = "0.3.6";
  };
  deps.rustc_demangle."0.1.13" = {};
  deps.rustc_version."0.2.3" = {
    semver = "0.9.0";
  };
  deps.scopeguard."0.3.3" = {};
  deps.semver."0.9.0" = {
    semver_parser = "0.7.0";
  };
  deps.semver_parser."0.7.0" = {};
  deps.serde."1.0.89" = {};
  deps.serde_derive."1.0.89" = {
    proc_macro2 = "0.4.27";
    quote = "0.6.11";
    syn = "0.15.29";
  };
  deps.serde_yaml."0.8.8" = {
    dtoa = "0.4.3";
    linked_hash_map = "0.5.1";
    serde = "1.0.89";
    yaml_rust = "0.4.3";
  };
  deps.signal_hook."0.1.8" = {
    arc_swap = "0.3.7";
    libc = "0.2.50";
  };
  deps.slab."0.4.2" = {};
  deps.smallvec."0.6.9" = {};
  deps.socket2."0.3.8" = {
    cfg_if = "0.1.7";
    libc = "0.2.50";
    redox_syscall = "0.1.51";
    winapi = "0.3.6";
  };
  deps.stable_deref_trait."1.1.1" = {};
  deps.syn."0.15.29" = {
    proc_macro2 = "0.4.27";
    quote = "0.6.11";
    unicode_xid = "0.1.0";
  };
  deps.synstructure."0.10.1" = {
    proc_macro2 = "0.4.27";
    quote = "0.6.11";
    syn = "0.15.29";
    unicode_xid = "0.1.0";
  };
  deps.tempfile."3.0.7" = {
    cfg_if = "0.1.7";
    rand = "0.6.5";
    remove_dir_all = "0.5.1";
    redox_syscall = "0.1.51";
    libc = "0.2.50";
    winapi = "0.3.6";
  };
  deps.termcolor."1.0.4" = {
    wincolor = "1.0.1";
  };
  deps.termion."1.5.1" = {
    libc = "0.2.50";
    redox_syscall = "0.1.51";
    redox_termios = "0.1.1";
  };
  deps.thread_local."0.3.6" = {
    lazy_static = "1.3.0";
  };
  deps.tokio."0.1.17" = {
    bytes = "0.4.12";
    futures = "0.1.25";
    mio = "0.6.16";
    num_cpus = "1.10.0";
    tokio_codec = "0.1.1";
    tokio_current_thread = "0.1.5";
    tokio_executor = "0.1.6";
    tokio_fs = "0.1.6";
    tokio_io = "0.1.12";
    tokio_reactor = "0.1.9";
    tokio_sync = "0.1.4";
    tokio_tcp = "0.1.3";
    tokio_threadpool = "0.1.12";
    tokio_timer = "0.2.10";
    tokio_trace_core = "0.1.0";
    tokio_udp = "0.1.3";
    tokio_uds = "0.2.5";
  };
  deps.tokio_codec."0.1.1" = {
    bytes = "0.4.12";
    futures = "0.1.25";
    tokio_io = "0.1.12";
  };
  deps.tokio_current_thread."0.1.5" = {
    futures = "0.1.25";
    tokio_executor = "0.1.6";
  };
  deps.tokio_executor."0.1.6" = {
    crossbeam_utils = "0.6.5";
    futures = "0.1.25";
  };
  deps.tokio_fs."0.1.6" = {
    futures = "0.1.25";
    tokio_io = "0.1.12";
    tokio_threadpool = "0.1.12";
  };
  deps.tokio_io."0.1.12" = {
    bytes = "0.4.12";
    futures = "0.1.25";
    log = "0.4.6";
  };
  deps.tokio_process."0.2.3" = {
    futures = "0.1.25";
    mio = "0.6.16";
    tokio_io = "0.1.12";
    tokio_reactor = "0.1.9";
    libc = "0.2.50";
    tokio_signal = "0.2.7";
    mio_named_pipes = "0.1.6";
    winapi = "0.3.6";
  };
  deps.tokio_reactor."0.1.9" = {
    crossbeam_utils = "0.6.5";
    futures = "0.1.25";
    lazy_static = "1.3.0";
    log = "0.4.6";
    mio = "0.6.16";
    num_cpus = "1.10.0";
    parking_lot = "0.7.1";
    slab = "0.4.2";
    tokio_executor = "0.1.6";
    tokio_io = "0.1.12";
    tokio_sync = "0.1.4";
  };
  deps.tokio_signal."0.2.7" = {
    futures = "0.1.25";
    mio = "0.6.16";
    tokio_executor = "0.1.6";
    tokio_io = "0.1.12";
    tokio_reactor = "0.1.9";
    libc = "0.2.50";
    mio_uds = "0.6.7";
    signal_hook = "0.1.8";
    winapi = "0.3.6";
  };
  deps.tokio_sync."0.1.4" = {
    fnv = "1.0.6";
    futures = "0.1.25";
  };
  deps.tokio_tcp."0.1.3" = {
    bytes = "0.4.12";
    futures = "0.1.25";
    iovec = "0.1.2";
    mio = "0.6.16";
    tokio_io = "0.1.12";
    tokio_reactor = "0.1.9";
  };
  deps.tokio_threadpool."0.1.12" = {
    crossbeam_deque = "0.7.1";
    crossbeam_queue = "0.1.2";
    crossbeam_utils = "0.6.5";
    futures = "0.1.25";
    log = "0.4.6";
    num_cpus = "1.10.0";
    rand = "0.6.5";
    slab = "0.4.2";
    tokio_executor = "0.1.6";
  };
  deps.tokio_timer."0.2.10" = {
    crossbeam_utils = "0.6.5";
    futures = "0.1.25";
    slab = "0.4.2";
    tokio_executor = "0.1.6";
  };
  deps.tokio_trace_core."0.1.0" = {
    lazy_static = "1.3.0";
  };
  deps.tokio_udp."0.1.3" = {
    bytes = "0.4.12";
    futures = "0.1.25";
    log = "0.4.6";
    mio = "0.6.16";
    tokio_codec = "0.1.1";
    tokio_io = "0.1.12";
    tokio_reactor = "0.1.9";
  };
  deps.tokio_uds."0.2.5" = {
    bytes = "0.4.12";
    futures = "0.1.25";
    iovec = "0.1.2";
    libc = "0.2.50";
    log = "0.4.6";
    mio = "0.6.16";
    mio_uds = "0.6.7";
    tokio_codec = "0.1.1";
    tokio_io = "0.1.12";
    tokio_reactor = "0.1.9";
  };
  deps.ucd_util."0.1.3" = {};
  deps.unicode_xid."0.1.0" = {};
  deps.utf8_ranges."1.0.2" = {};
  deps.void."1.0.2" = {};
  deps.winapi."0.2.8" = {};
  deps.winapi."0.3.6" = {
    winapi_i686_pc_windows_gnu = "0.4.0";
    winapi_x86_64_pc_windows_gnu = "0.4.0";
  };
  deps.winapi_build."0.1.1" = {};
  deps.winapi_i686_pc_windows_gnu."0.4.0" = {};
  deps.winapi_util."0.1.2" = {
    winapi = "0.3.6";
  };
  deps.winapi_x86_64_pc_windows_gnu."0.4.0" = {};
  deps.wincolor."1.0.1" = {
    winapi = "0.3.6";
    winapi_util = "0.1.2";
  };
  deps.winutil."0.1.1" = {
    winapi = "0.3.6";
  };
  deps.ws2_32_sys."0.2.1" = {
    winapi = "0.2.8";
    winapi_build = "0.1.1";
  };
  deps.yaml_rust."0.4.3" = {
    linked_hash_map = "0.5.1";
  };
}
