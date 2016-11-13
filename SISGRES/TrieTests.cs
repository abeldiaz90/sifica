using System;
using System.Diagnostics;
using System.IO;
using NUnit.Framework;

namespace DataStructures.AutoComplete.UnitTests
{
	[TestFixture]
	public class TrieTests
	{

		[Test]
		public void FindInTrieTest()
		{
			var trie = new Trie();
			trie.Add("Donald Duck");
			trie.Add("Duffy Duck");
			trie.Add("Mini Mouse");
			trie.Add("Mickey Mouse");
			trie.Add("Pluto Dog");
			trie.Add("Guffy Dog");
			trie.Add("Donald Trump");
			trie.Add("Donald White");
			trie.Add("Pluto Planet");
			trie.Add("abc");
			trie.Add("aba");
			trie.Add("abb");
			trie.Add("aaa");
			trie.Add("bbb");
			trie.Add("bbc");
			trie.Add("ccc");
			trie.Add("a");
			trie.Add("ab");
			trie.Add("aab");
			trie.Add("b");
			trie.Add("bc");
			trie.Add("bb");
			trie.Add("aaaa");
			trie.Add("aaaaa");
			trie.Add("axxaa");
			trie.Add("axaxa");

			var list = trie.GetCompletionList("d");
			Assert.Contains("donald duck", list);
			Assert.AreEqual(4, list.Count);

			list = trie.GetCompletionList("donald t");
			Assert.Contains("donald trump", list);

			list = trie.GetCompletionList("Donald");
			Assert.Contains("donald trump", list);
			Assert.AreEqual(3, list.Count);

			list = trie.GetCompletionList("a", 6);
			Assert.AreEqual(6, list.Count);

			list = trie.GetCompletionList("a");
			Assert.AreEqual(11, list.Count);
		}

		[Test]
		public void FindInCaseSensitiveTrieTest()
		{
			var trie = new Trie(true);
			trie.Add("Donald Duck");
			trie.Add("Duffy Duck");
			trie.Add("Mini Mouse");
			trie.Add("Mickey Mouse");
			trie.Add("Pluto Dog");
			trie.Add("Guffy Dog");
			trie.Add("Donald Trump");
			trie.Add("Donald White");
			trie.Add("Pluto Planet");
			trie.Add("delta force");
			trie.Add("abc");
			trie.Add("aba");
			trie.Add("abb");
			trie.Add("aaa");
			trie.Add("bbb");
			trie.Add("bbc");
			trie.Add("ccc");
			trie.Add("a");
			trie.Add("ab");
			trie.Add("aab");
			trie.Add("b");
			trie.Add("bc");
			trie.Add("bb");
			trie.Add("aaaa");
			trie.Add("aaaaa");
			trie.Add("axxaa");
			trie.Add("axaxa");

			var list = trie.GetCompletionList("D");
			Assert.Contains("Donald Duck", list);
			Assert.AreEqual(4, list.Count);

			list = trie.GetCompletionList("mickey Mouse");
			Assert.AreEqual(0, list.Count);

			list = trie.GetCompletionList("Donald T");
			Assert.Contains("Donald Trump", list);

			list = trie.GetCompletionList("Donald");
			Assert.Contains("Donald Trump", list);
			Assert.AreEqual(3, list.Count);

			list = trie.GetCompletionList("a", 6);
			Assert.AreEqual(6, list.Count);

			list = trie.GetCompletionList("a");
			Assert.AreEqual(11, list.Count);

			list = trie.GetCompletionList("A");
			Assert.AreEqual(0, list.Count);
		}

		[Test]
		public void NotFoundTrieTest()
		{
			var trie = new Trie();
			trie.Add("Donald Duck");
			trie.Add("Duffy Duck");
			trie.Add("Mini Mouse");
			trie.Add("Mickey Mouse");
			trie.Add("Pluto Dog");
			trie.Add("Guffy Dog");

			var list = trie.GetCompletionList("xx");
			Assert.AreEqual(0, list.Count);
		}

		[Test]
		public void SingleResultTrieTest()
		{
			var trie = new Trie();
			trie.Add("Donald Duck");
			trie.Add("Duffy Duck");
			trie.Add("Mini Mouse");
			trie.Add("Mickey Mouse");
			trie.Add("Pluto Dog");
			trie.Add("Guffy Dog");

			var list = trie.GetCompletionList("Do");
			Assert.Contains("donald duck", list);
			Assert.AreEqual(1, list.Count);
		}

		/// <summary>
		/// Builds a very large Trie to check performance and stress
		/// </summary>
		[Test]
		public void TryBigTrie()
		{
			Trie BigTrie = new Trie();
			string REGEX = @"([\w]+\s+){1}";
			var regX = new System.Text.RegularExpressions.Regex(REGEX, System.Text.RegularExpressions.RegexOptions.Compiled);
			long memoryStart = System.GC.GetTotalMemory(true);
			Stopwatch watch = Stopwatch.StartNew();

			// This test uses the large AGID wordlist from: http://wordlist.sourceforge.net/
			// which has about 112,000 words in it.
			// but you can use anything to feed this test with a long word list.
			using (StreamReader sr = new StreamReader("..\\..\\..\\infl.txt"))
			{
				String line;
				// Read lines from the file until the end of the file is reached.
				while ((line = sr.ReadLine()) != null)
				{
					// Get the first word in the line
					string word = regX.Match(line).Value;
					BigTrie.Add(word);
					//Trace.WriteLine("Writing: " + word);
				}
			}
			Trace.WriteLine("Trie build time: " + watch.ElapsedMilliseconds + " ms.");
			long memoryUsed = System.GC.GetTotalMemory(true) - memoryStart;
			Trace.WriteLine("Trie uses aprox: " + memoryUsed.ToString() + " bytes.");

			watch = Stopwatch.StartNew();
			var words = BigTrie.GetCompletionList("b", 2000);
			Trace.WriteLine("Trie returned completion list in: " + watch.ElapsedMilliseconds + " ms.");
			Assert.AreEqual(2000, words.Count);
			//uncomment this to see the returned word list
			//words.ForEach(w => { Trace.WriteLine(w); });

		}

	}

}


