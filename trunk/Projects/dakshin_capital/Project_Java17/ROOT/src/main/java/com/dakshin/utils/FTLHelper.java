package com.dakshin.utils;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;

import javax.servlet.ServletContext;

import org.hibernate.internal.util.StringHelper;

import freemarker.template.Configuration;
import freemarker.template.SimpleHash;
import freemarker.template.Template;
import freemarker.template.TemplateException;


public class FTLHelper {

	@SuppressWarnings("deprecation")
	public static String getMailBody(SimpleHash simpleHash, String templateName, ServletContext context) 
	{
		StringWriter writer = new StringWriter();
		if (simpleHash != null && templateName != null && context != null) 
		{
			Configuration configure = new Configuration();
			configure.setServletContextForTemplateLoading(context,"WEB-INF" + File.separator + "ftltemplate");

			try {
				templateName = getValidFTLFilename(templateName);
				if (StringHelper.isNotEmpty(templateName)) 
				{
					Template template = configure.getTemplate(getValidFTLFilename(templateName));
					template.process(simpleHash, writer);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} catch (TemplateException e) {
				e.printStackTrace();
			}
		}
		return writer.toString();
	}

	private static String getValidFTLFilename(String name) 
	{
		if (StringHelper.isNotEmpty(name))
		{
			if (name.lastIndexOf(".ftl") == -1) 
			{
				name = name.concat(".ftl");
			}
		}
		return name;
	}
}
