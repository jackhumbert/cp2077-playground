module CodexFilter

@addField(CodexListVirtualNestedDataView)
public let m_currentTextFilter: String;

@addMethod(CodexListVirtualNestedDataView)
public final func SetTextFilter(filterTerm: String) -> Void {
	this.m_currentTextFilter = StrUpper(filterTerm);
	this.Filter();
	this.EnableSorting();
	this.Sort();
	this.DisableSorting();
}

@wrapMethod(CodexListVirtualNestedDataView)
protected func FilterItems(data: ref<VirutalNestedListData>) -> Bool {
	if !wrappedMethod(data) {
		return false;
	}

	/*data.m_isHeader ||*/
	if StrLen(this.m_currentTextFilter) == 0 {
		return true;
	}

	let entryData: ref<CodexEntryData> = data.m_data as CodexEntryData;

	return CodexFilter.Match(entryData, this.m_currentTextFilter);
}
