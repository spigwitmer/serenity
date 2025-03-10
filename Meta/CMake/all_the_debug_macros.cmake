set(PROCESS_DEBUG ON)
set(SCHEDULER_DEBUG ON)
set(SCHEDULER_RUNNABLE_DEBUG ON)
set(THREAD_DEBUG ON)
set(LOCK_DEBUG ON)
set(SIGNAL_DEBUG ON)
set(BMP_DEBUG ON)
set(WAITBLOCK_DEBUG ON)
set(WAITQUEUE_DEBUG ON)
set(MULTIPROCESSOR_DEBUG ON)
set(ACPI_DEBUG ON)
set(PAGE_FAULT_DEBUG ON)
set(CONTEXT_SWITCH_DEBUG ON)
set(SMP_DEBUG ON)
set(BXVGA_DEBUG ON)
set(PS2MOUSE_DEBUG ON)
set(MOUSE_DEBUG ON)
set(VMWARE_BACKDOOR_DEBUG ON)
set(VIRTUAL_CONSOLE_DEBUG ON)
set(FILEDESCRIPTION_DEBUG ON)
set(PROCFS_DEBUG ON)
set(VFS_DEBUG ON)
set(VIRTIO_DEBUG ON)
set(IOAPIC_DEBUG ON)
set(IRQ_DEBUG ON)
set(INTERRUPT_DEBUG ON)
set(E1000_DEBUG ON)
set(IPV4_SOCKET_DEBUG ON)
set(LOCAL_SOCKET_DEBUG ON)
set(SOCKET_DEBUG ON)
set(TCP_SOCKET_DEBUG ON)
set(PCI_DEBUG ON)
set(PATA_DEBUG ON)
set(AHCI_DEBUG ON)
set(IO_DEBUG ON)
set(FORK_DEBUG ON)
set(POLL_SELECT_DEBUG ON)
set(HPET_DEBUG ON)
set(HPET_COMPARATOR_DEBUG ON)
set(MASTERPTY_DEBUG ON)
set(SLAVEPTY_DEBUG ON)
set(PTMX_DEBUG ON)
set(TTY_DEBUG ON)
set(CONTIGUOUS_VMOBJECT_DEBUG ON)
set(VRA_DEBUG ON)
set(COPY_DEBUG ON)
set(CURSOR_TOOL_DEBUG ON)
set(FILE_CONTENT_DEBUG ON)
set(GZIP_DEBUG ON)
set(CNETWORKJOB_DEBUG ON)
set(CSOCKET_DEBUG ON)
set(CSS_LOADER_DEBUG ON)
set(SAFE_SYSCALL_DEBUG ON)
set(GHASH_PROCESS_DEBUG ON)
set(NT_DEBUG ON)
set(CRYPTO_DEBUG ON)
set(DWARF_DEBUG ON)
set(HUNKS_DEBUG ON)
set(JOB_DEBUG ON)
set(GIF_DEBUG ON)
set(JPG_DEBUG ON)
set(EMOJI_DEBUG ON)
set(FILL_PATH_DEBUG ON)
set(PNG_DEBUG ON)
set(PORTABLE_IMAGE_LOADER_DEBUG ON)
set(SYNTAX_HIGHLIGHTING_DEBUG ON)
set(KEYBOARD_SHORTCUTS_DEBUG ON)
set(KMALLOC_DEBUG ON)
set(KMALLOC_VERIFY_NO_SPINLOCK_HELD ON)
set(MARKDOWN_DEBUG ON)
set(REGEX_DEBUG ON)
set(TLS_DEBUG ON)
set(SPAM_DEBUG ON)
set(SQL_DEBUG ON)
set(PARSER_DEBUG ON)
set(TOKENIZER_TRACE_DEBUG ON)
set(IMAGE_LOADER_DEBUG ON)
set(RESOURCE_DEBUG ON)
set(CACHE_DEBUG ON)
set(DHCPV4_DEBUG ON)
set(DHCPV4CLIENT_DEBUG ON)
set(IMAGE_DECODER_DEBUG ON)
set(SYSTEM_MENU_DEBUG ON)
set(SYSTEMSERVER_DEBUG ON)
set(SERVICE_DEBUG ON)
set(COMPOSE_DEBUG ON)
set(MINIMIZE_ANIMATION_DEBUG ON)
set(OCCLUSIONS_DEBUG ON)
set(MENUS_DEBUG ON)
set(WSSCREEN_DEBUG ON)
set(WINDOWMANAGER_DEBUG ON)
set(RESIZE_DEBUG ON)
set(MOVE_DEBUG ON)
set(DOUBLECLICK_DEBUG ON)
set(DISASM_DUMP_DEBUG ON)
set(PATH_DEBUG ON)
set(LOCK_TRACE_DEBUG ON)
set(LOCK_RESTORE_DEBUG ON)
set(FUTEXQUEUE_DEBUG ON)
set(FUTEX_DEBUG ON)
set(UHCI_DEBUG ON)
set(APIC_DEBUG ON)
set(APIC_SMP_DEBUG ON)
set(ARP_DEBUG ON)
set(AWAVLOADER_DEBUG ON)
set(BBFS_DEBUG ON)
set(CALLBACK_MACHINE_DEBUG ON)
set(CHTTPJOB_DEBUG ON)
set(COMMIT_DEBUG ON)
set(AUTOCOMPLETE_DEBUG ON)
set(CPP_LANGUAGE_SERVER_DEBUG ON)
set(DIFF_DEBUG ON)
set(HIGHLIGHT_FOCUSED_FRAME_DEBUG ON)
set(ITEM_RECTS_DEBUG ON)
set(SH_LANGUAGE_SERVER_DEBUG ON)
set(TEXTEDITOR_DEBUG ON)
set(DEFERRED_INVOKE_DEBUG ON)
set(DYNAMIC_LOAD_DEBUG ON)
set(EDITOR_DEBUG ON)
set(ELF_IMAGE_DEBUG ON)
set(ETHERNET_DEBUG ON)
set(ETHERNET_VERY_DEBUG ON)
set(EVENT_DEBUG ON)
set(EVENTLOOP_DEBUG ON)
set(EXEC_DEBUG ON)
set(EXT2_DEBUG ON)
set(EXT2_BLOCKLIST_DEBUG ON)
set(EXT2_VERY_DEBUG ON)
set(GEMINI_DEBUG ON)
set(GEMINIJOB_DEBUG ON)
set(GENERATE_DEBUG_CODE ON)
set(GLOBAL_DTORS_DEBUG ON)
set(HEAP_DEBUG ON)
set(HEX_DEBUG ON)
set(HTML_SCRIPT_DEBUG ON)
set(HTTPSJOB_DEBUG ON)
set(ICMP_DEBUG ON)
set(ICO_DEBUG ON)
set(IPV4_DEBUG ON)
set(INTEL_GRAPHICS_DEBUG ON)
set(IRC_DEBUG ON)
set(KEYBOARD_DEBUG ON)
set(LEXER_DEBUG ON)
set(LOOKUPSERVER_DEBUG ON)
set(MALLOC_DEBUG ON)
set(MBR_DEBUG ON)
set(MEMORY_DEBUG ON)
set(MENU_DEBUG ON)
set(NETWORK_TASK_DEBUG ON)
set(OBJECT_DEBUG ON)
set(OFFD_DEBUG ON)
set(PROMISE_DEBUG ON)
set(PTHREAD_DEBUG ON)
set(REACHABLE_DEBUG ON)
set(ROUTING_DEBUG ON)
set(NE2000_DEBUG ON)
set(RTL8139_DEBUG ON)
set(SB16_DEBUG ON)
set(SH_DEBUG ON)
set(STORAGE_DEVICE_DEBUG ON)
set(TCP_DEBUG ON)
set(TERMCAP_DEBUG ON)
set(TERMINAL_DEBUG ON)
set(ESCAPE_SEQUENCE_DEBUG ON)
set(UCI_DEBUG ON)
set(UDP_DEBUG ON)
set(UHCI_VERBOSE_DEBUG ON)
set(UPDATE_COALESCING_DEBUG ON)
set(VOLATILE_PAGE_RANGES_DEBUG ON)
set(WSMESSAGELOOP_DEBUG ON)
set(GPT_DEBUG ON)
set(CPP_DEBUG ON)
set(DEBUG_CPP_LANGUAGE_SERVER ON)
set(DEBUG_AUTOCOMPLETE ON)
set(FILE_WATCHER_DEBUG ON)
set(SYSCALL_1_DEBUG ON)
set(RSA_PARSE_DEBUG ON)
set(LINE_EDITOR_DEBUG ON)
set(LANGUAGE_SERVER_DEBUG ON)
set(GL_DEBUG ON)
set(WASM_BINPARSER_DEBUG ON)
set(WASM_TRACE_DEBUG ON)
set(PDF_DEBUG ON)
set(SOLITAIRE_DEBUG ON)

# False positive: DEBUG is a flag but it works differently.
# set(DEBUG ON)
# False positive: DT_DEBUG is a flag, but for a bitset, not a feature.
# set(DT_DEBUG ON)
# False positive: GUI_DND_DEBUG is a flag, but passed as an envvar.
# set(GUI_DND_DEBUG ON)
# False positive: GUI_FOCUS_DEBUG is a flag, but passed as an envvar.
# set(GUI_FOCUS_DEBUG ON)
# False positive: LOG_DEBUG is a flag, but for a bitset, not a feature.
# set(LOG_DEBUG ON)
# False positive: UHCI_USBCMD_SOFTWARE_DEBUG is a flag, but for a bitset, not a feature.
# set(UHCI_USBCMD_SOFTWARE_DEBUG ON)
# False positive: DEBUG_CONTROL_REGISTER represents a specification constant.
# set(DEBUG_CONTROL_REGISTER ON)
# False positive: DEBUG_STATUS_REGISTER represents a specification constant.
# set(DEBUG_STATUS_REGISTER ON)
# False positive: DEFINE_DEBUG_REGISTER is used to define read/write methods for debug registers.
# set(DEFINE_DEBUG_REGISTER ON)
# Clogs up build: The WrapperGenerator stuff is run at compile time.
# set(WRAPPER_GENERATOR_DEBUG ON)
