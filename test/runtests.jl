# runtests

using GMime
using Test, Dates

@testset "Parse Email" begin
    @testset "Case №1: simple email" begin
        data = read("emails/simple.eml")
        email = parse_email(data)

        @test email.from == ["Test User <username@example.com>"]
        @test email.to == ["Test User <username@example.com>"]
        @test email.date == DateTime("1996-03-05 11:00:00", DateFormat("yyyy-mm-dd HH:MM:SS"))
        @test !isempty(email.text_body)
        @test isempty(email.attachments)
    end

    @testset "Case №2: email with attachments" begin
        data = read("emails/attachments.eml")
        email = parse_email(data)

        @test email.from == ["Test User <username@example.com>"]
        @test email.to == ["Test User <username@example.com>"]
        @test email.date == DateTime("1996-03-05 11:00:00", DateFormat("yyyy-mm-dd HH:MM:SS"))
        @test !isempty(email.text_body)
        @test length(email.attachments) == 5
    end

    @testset "Case №3: empty email" begin
        data = read("emails/empty0.msg")
        email = parse_email(data)

        @test email.from == ["Peter Bloomfield <PeterBloomfield@bellsouth.net>"]
        @test email.to == ["Peter Bloomfield <PeterBloomfield@BellSouth.net>"]
        @test email.date == DateTime("2003-12-06 15:41:26", DateFormat("yyyy-mm-dd HH:MM:SS"))
        @test length(email.text_body) == 1
        @test isempty(email.attachments)
    end

    @testset "Case №4: mbox email" begin
        data = read("emails/substring.mbox")
        email = parse_email(data)
        
        @test email.from == ["fejj@gnome.org"]
        @test email.to == ["fejj@gnome.org"]
        @test email.date == DateTime("2002-08-23 02:32:53", DateFormat("yyyy-mm-dd HH:MM:SS"))
        @test !isempty(email.text_body)
        @test isempty(email.attachments)
    end

    @testset "Case №5: mbox email" begin
        data = read("emails/jwz.mbox")
        email = parse_email(data)
        
        @test email.from == ["nsb"]
        @test length(email.to) == 18
        @test email.date == DateTime("1991-09-19 12:41:43", DateFormat("yyyy-mm-dd HH:MM:SS"))
        @test !isempty(email.text_body)
        @test isempty(email.attachments)
    end

    @testset "Case №6: more emails" begin
        email = @test_nowarn parse_email(read("emails/missing_date.eml"))
        @test isnothing(email.date)
        email = @test_nowarn parse_email(read("emails/broken_fields.eml"))
        @test isnothing(email.attachments[1].encoding)
        @test isnothing(email.attachments[1].name)
        @test_nowarn parse_email(read("emails/eml_as_attachment.eml"))
    end
end