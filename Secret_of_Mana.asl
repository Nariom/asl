state("Secret_of_Mana") {
  byte noControl : "Secret_of_Mana.exe", 0xE3D769;
}

init {
  vars.mwl = new MemoryWatcherList();
  vars.addr = IntPtr.Zero;
}

update {
  if ( (IntPtr) vars.addr == IntPtr.Zero) {
    vars.addr = memory.ReadValue<int>( (IntPtr) 0x01242870 );
    print("addr: " + vars.addr.ToString());
    if ( (IntPtr) vars.addr != IntPtr.Zero) {
      vars.mwl.Add(
        new MemoryWatcher<byte>( (IntPtr) vars.addr + 0x23C )
        { Name = "notInGame" }
      );
    }
  }
  vars.mwl.UpdateAll( game );
}

isLoading {
  return ( vars.mwl["notInGame"].Current == 1 && current.noControl == 1 );
}
